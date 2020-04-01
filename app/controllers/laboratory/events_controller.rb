class Laboratory::EventsController < ApplicationController
  before_action :authenticate_laboratory!
  before_action :set_lab

  def index
    @event = Event.new
    @events = @lab.events.all
    
    respond_to do |format|
      format.html
      format.json{
        data = []
        colors = {
          office:     "#fcf8e3",
          experiment: "#fcf8e3",
          machining:  "#fcf8e3",
          ogigaoka:   "#d9edf7",
          cafeteria:  "#f2dede",
          classwork:  "#dff0d8",
          offcampus:  "#dff0d8",
          athome:     "#337ab7",
          jobhunt:    "#337ab7",
          absence:    "#337ab7",
          homecaming: "#337ab7",
        }
        @events.each do |event|
          hash = {
                  "title": "#{event.member.lastname} / #{event.status_i18n}",
                  "start": event.started_at,
                  "end": event.finished_at,
                  "allDay": event.all_day,
                  "member": event.member.lastname,
                  "cause": event.title,
                  "status": Event.statuses.keys.index(event.status),
                  "color": colors[event.status.intern],
                  "id": event.id
          }
          data << hash
        end
        render json: data
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
  
  def destroy
    @event = Event.find(params[:id])
    if @event.delete
      redirect_to laboratory_events_path, notice: "削除しました"
    else
      flash.now[:alert] = "削除に失敗しました"
      render :index
    end
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
