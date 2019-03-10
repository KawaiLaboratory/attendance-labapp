class LaboratoriesController < ApplicationController
  before_action :set_lab, only: [:show, :edit, :update]
  before_action :authenticate_laboratory!
  
  def index
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
  
  def lab_params
    # params.require(:laboratory).permit(:displayname, :password, members_attributes:[:id, :name, :grade, :_destroy])
    params.require(:laboratory).permit(:displayname, :place, members_attributes:[:id, :lastname, :firstname, :go_cafeteria, :grade, :_destroy])
  end
end
