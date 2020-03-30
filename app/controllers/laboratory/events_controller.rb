class Laboratory::EventsController < ApplicationController
  before_action :authenticate_laboratory!
  before_action :set_lab

  def index
    @event = Event.new
    @events = @lab.events.all
    
    respond_to do |format|
      format.html
      format.json{
        render json: [{title: "aaa", start: "2020-03-03"}, {title: "aaa", start: "2020-03-05"}]
      }
    end
  end

  def create
    @event = @lab.events.build(event_params)
    if @event.save
      redirect_to laboratory_events_path, notice: "作成しました"
    else
      flash.now[:alert] = "作成に失敗しました"
      render :index
    end
  end

  def update
  end
  
  private

  def set_lab
    @lab = Laboratory.find(current_laboratory.id)
  end

  def event_params
    # params.require(:laboratory).permit(:displayname, :password, members_attributes:[:id, :name, :grade, :_destroy])
    params.require(:event).permit(:started_at, :finished_at, :member_id, :status, :title, :all_day)
  end
end
