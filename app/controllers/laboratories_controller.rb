class LaboratoriesController < ApplicationController
  before_action :set_lab, only: [:show, :edit, :update]
  
  def index
  end

  def show
  end

  def edit
  end

  def update
  end
  
  private
  
  def set_lab
    @lab = Laboratory.find_by(loginname: params[:loginname])
  end
end
