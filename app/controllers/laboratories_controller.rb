class LaboratoriesController < ApplicationController
  before_action :set_lab, only: [:show, :edit, :update]
  before_action :authenticate_laboratory!
  
  def index
    @colors = {
      office:     "warning",
      experiment: "warning",
      machining:  "warning",
      ogigaoka:   "info",
      cafeteria:  "danger",
      classwork:  "success",
      offcampus:  "success",
      athome:     "primary",
      jobhunt:    "primary",
      absence:    "primary",
      homecaming: "primary",
    }
  end

  def show
    respond_to do |format|
      format.html do
        @period = (Date.current-6.days)..(Date.current)
      end
      
      format.csv do
        @member = @lab.members.find_by(id: params[:member_id])
        @period = (Date.current-100.days)..(Date.current)
        filename = "#{@member.lastname}_logs"
        headers["Content-Disposition"] = "attachment; filename=\"#{filename}.csv\""
      end
    end
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
    if params[:name] == current_laboratory.name
      if action_name == "show"
        @lab = Laboratory.includes(members: :logs).find_by(name: params[:name])
      else
        @lab = Laboratory.includes(:members).find_by(name: params[:name])
      end
    else
      redirect_to root_path, alert: "URLが間違っています"
    end
  end
  
  def lab_params
    # params.require(:laboratory).permit(:displayname, :password, members_attributes:[:id, :name, :grade, :_destroy])
    params.require(:laboratory).permit(:displayname, :place, members_attributes:[:id, :lastname, :firstname, :go_cafeteria, :grade, :class_number, :_destroy])
  end
end
