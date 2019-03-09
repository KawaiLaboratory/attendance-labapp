class LaboratoriesController < ApplicationController
  before_action :set_lab, only: [:show, :edit, :update]
  before_action :check_name, only: [:show, :edit]
  
  def index
    @lab = @current_user
  end

  def show
  end

  def edit
  end

  def update
    #if check_pass && @lab.update(lab_params)
    if @lab.update(lab_params)
      redirect_to root_path, notice: "更新しました"
    else
      render :edit
    end
  end
  
  private

  def set_lab
    @lab = Laboratory.find_by(loginname: params[:loginname])
  end
  
  def check_name
    if @current_user.loginname != params[:loginname]
      redirect_to root_path, alert: "権限がありません"
    end
  end
  
  # def check_pass
  #   params[:laboratory][:password] == params[:laboratory][:password_confirmation]
  # end
  
  def lab_params
    # params.require(:laboratory).permit(:displayname, :password, members_attributes:[:id, :name, :grade, :_destroy])
    params.require(:laboratory).permit(:displayname, members_attributes:[:id, :name, :grade, :_destroy])
  end
end
