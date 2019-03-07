class SessionsController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]
  before_action :set_lab, only: [:create]
  
  def new
  end
  
  def create
    if @lab.authenticate(session_params[:password])
      sign_in(@lab)
      redirect_to root_path, notice: "ログインしました"
    else
      flash.now[:alert] = "パスワードが間違っています"
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to log_in_path, notice: "ログアウトしました"
  end
  
  private
  
  def set_lab
    @lab = Laboratory.find_by!(loginname: session_params[:loginname])
  rescue
    flash.now[:alert] = "ログイン名が間違っています"
    render action: 'new'
  end
  
  def session_params
    params.require(:session).permit(:loginname, :password)
  end
end
