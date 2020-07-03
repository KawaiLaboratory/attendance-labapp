class LaboratoriesController < ApplicationController
  before_action :authenticate_laboratory!
  before_action :set_lab
  
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
    date = Date.current
    respond_to do |format|
      format.html do
        @period = (date-6.days..date)
        @f_year = Array.new(12) { |n| date.beginning_of_financial_year + n.month }
      end
      
      format.csv do
        @member = @lab.members.find_by(id: params[:member_id])
        @period = (date-100.days..date)
        filename = "#{@member.lastname}_logs"
        headers["Content-Disposition"] = "attachment; filename=\"#{filename}.csv\""
      end
    end
  end

  def edit
  end

  def update
    if @lab.update(lab_params)
      redirect_to root_path, notice: "更新しました"
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit
    end
  end
  
  def ajax
    render json: {date: @lab.member_updated_at.strftime("%Y%m%d%H%M%S")}
  end
  
  def all_logs
    date = Date.current
    respond_to do |format|
      format.csv do
        @period = date.beginning_of_financial_year..date.end_of_financial_year
        filename = "all_logs_at_#{date.financial_year}"
        headers["Content-Disposition"] = "attachment; filename=\"#{filename}.csv\""
      end
    end
  end
  
  private

  def set_lab
    if action_name == "show"
      @lab = Laboratory.includes(members: :logs).find_by(name: current_laboratory.name)
    else
      @lab = Laboratory.includes(:members).find_by(name: current_laboratory.name)
    end
  end
  
  def lab_params
    # params.require(:laboratory).permit(:displayname, :password, members_attributes:[:id, :name, :grade, :_destroy])
    params.require(:laboratory).permit(:displayname, :place, :slack_url, members_attributes:[:id, :lastname, :firstname, :go_cafeteria, :grade, :class_number, :_destroy])
  end
end
