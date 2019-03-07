class MembersController < ApplicationController
  def update
    @members = member_params.each do |id, member_param|
      member = Member.find(id)
      member.update_attributes(member_param)
    end
    redirect_to root_path
  end
  
  private
  
  def member_params
    params.permit(members: [:status]).require(:members)
  end
end
