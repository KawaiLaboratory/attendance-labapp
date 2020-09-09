class MembersController < ApplicationController
  before_action :authenticate_laboratory!
  before_action :set_lab
  
  def update
    changed_at = DateTime.current
    message = []
    # メソッド切ったり色々する
    if params[:go_cafeteria]
      @lab.members.where(status: 0..2).each do | member |
        if member.go_cafeteria?
          member.change_status(Member.statuses[:cafeteria], changed_at)
        end
      end
      message << "食堂へ行きました"
    elsif params[:finished_lanch]
      @lab.members.cafeteria.each do | member |
        member.change_status(Member.statuses[:office], changed_at)
      end
      message << "食堂から戻りました"
    elsif params[:go_home]
      @lab.members.where(status: 0..6).each do | member |
        member.change_status(Member.statuses[:athome], changed_at)
      end
      message << "全員帰宅しました"
    elsif params[:update_status] #スマホ用
      member_params.each do |id, member_param|
        member = @lab.members.find(id)
        if member.status != member_param[:status]
          before_status = member.status_i18n
          member.change_status(member_param[:status], changed_at)
          message << "#{member.lastname}が#{before_status}から#{member.status_i18n}になりました"
        end
      end
    else #PC(ajax)用
      member_params.each do |id, member_param|
        member = @lab.members.find(id)
        if member.status != member_param[:status]
          before_status = member.status_i18n
          member.change_status(member_param[:status], changed_at)
          message << "#{member.lastname}が#{before_status}から#{member.status_i18n}になりました"
        end
      end
      @lab.update(member_updated_at: changed_at)
      send_to_slack(message)
      render json: {"updated_at": changed_at.strftime("%Y%m%d%H%M%S"), "message": message}
      return
    end
    @lab.update(member_updated_at: changed_at)
    send_to_slack(message)
    redirect_to root_path
    return
  end
  
  private
  
  def send_to_slack(message)
    if Rails.env == 'production' && @lab.slack_url.present?
    #if @lab.slack_url.present?
      notifier = Slack::Notifier.new(@lab.slack_url)
      message.each do |m|
        notifier.ping(m)
      end
    end
  end
  
  def set_lab
    @lab = Laboratory.find_by(name: current_laboratory.name)
  end
  
  def member_params
    params.permit(members: [:status]).require(:members)
  end
end
