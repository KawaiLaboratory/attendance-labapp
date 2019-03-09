class MembersController < ApplicationController
  def update
    @members = member_params.each do |id, member_param|
      member = Member.find(id)
      if member.status != member_param[:status]
        changed_at = DateTime.current
        member.logs.build(
          total_time: (changed_at.to_i - member.changed_at.to_i),
          status: member.status
        )
        member.update(member_param.merge(changed_at: changed_at))
      end
    end
    redirect_to root_path
  end
  
  private
  
  def member_params
    params.permit(members: [:status]).require(:members)
  end
end
