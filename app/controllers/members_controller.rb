class MembersController < ApplicationController
  def update
    changed_at = DateTime.current
    # メソッド切ったり色々する
    if params[:go_cafeteria]
      Member.where(id: member_params.keys).where(status: 0..2).each do | member |
        if member.go_cafeteria?
          member.change_status(Member.statuses[:cafeteria], changed_at)
        end
      end
    elsif params[:finished_lanch]
      Member.where(id: member_params.keys).cafeteria.each do | member |
        member.change_status(Member.statuses[:office], changed_at)
      end
    elsif params[:go_home]
      Member.where(id: member_params.keys).where(status: 0..6).each do | member |
        member.change_status(Member.statuses[:athome], changed_at)
      end
    else
      member_params.each do |id, member_param|
        member = Member.find(id)
        if member.status != member_param[:status]
          member.change_status(member_param[:status], changed_at)
        end
      end
    end
    redirect_to root_path
  end
  
  private
  
  def member_params
    params.permit(members: [:status]).require(:members)
  end
end
