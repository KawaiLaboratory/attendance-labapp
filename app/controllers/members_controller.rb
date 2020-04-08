class MembersController < ApplicationController
  before_action :authenticate_laboratory!

  def update
    changed_at = DateTime.current
    message = []
    # メソッド切ったり色々する
    if params[:go_cafeteria]
      current_laboratory.members.where(status: 0..2).each do | member |
        if member.go_cafeteria?
          member.change_status(Member.statuses[:cafeteria], changed_at)
        end
        message << "食堂へ行きました"
      end
    elsif params[:finished_lanch]
      current_laboratory.members.cafeteria.each do | member |
        member.change_status(Member.statuses[:office], changed_at)
      end
      message << "食堂から戻りました"
    elsif params[:go_home]
      current_laboratory.members.where(status: 0..6).each do | member |
        member.change_status(Member.statuses[:athome], changed_at)
      end
      message << "全員帰宅しました"
    else
      member_params.each do |id, member_param|
        member = current_laboratory.members.find(id)
        if member.status != member_param[:status]
          message << "#{member.lastname}が#{member.status}から#{member_param[:status]}になりました"
          member.change_status(member_param[:status], changed_at)
        end
      end
    end
    current_laboratory.update(member_updated_at: changed_at)
    if Rails.env == 'production'
      notifier = Slack::Notifier.new(
        env['WEBHOOK_URL'],
        channel: '#' + env['CHANNEL']
      )
      message.each do |m|
        notifier.ping m
      end
    end
    redirect_to root_path
  end
  
  private
  
  def member_params
    params.permit(members: [:status]).require(:members)
  end
end
