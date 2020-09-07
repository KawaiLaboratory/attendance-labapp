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
          office:     "#f0ad4e",
          experiment: "#f0ad4e",
          machining:  "#f0ad4e",
          ogigaoka:   "#5bc0de",
          cafeteria:  "#d9534f",
          classwork:  "#5cb85c",
          offcampus:  "#5cb85c",
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
  
  def edit
    @event = @lab.events.find(params[:id])
    render partial: "edit_form", locals: {event: @event}
  end

  def update
    @event = Event.find(params[:event][:id])
    if @event.update(event_params)
      redirect_to  laboratory_events_path, notice: "更新しました"
    else
      flash.now[:alert] = "更新に失敗しました"
      render :index
    end
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
