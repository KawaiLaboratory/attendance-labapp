class ApplicationController < ActionController::Base
  include Jpmobile::ViewSelector

  def after_sign_in_path_for(resource)
    if resource.members.blank?
      edit_laboratory_path(resource)
    else
      root_path
    end
  end
  
  def after_sign_out_path_for(resource)
    new_laboratory_session_path 
  end
end
