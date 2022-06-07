class NotificationController < ApplicationController
  before_action :find_notification, only: [:show, :destroy, :update, :edit]
  before_action :notif_params, only: [:create, :update]
  def show
    @notification
  end

  def create
    @notification = Notifications.new(notif_params)
    if @notification.save
      render :json @notification.to_json
    else
      render :json {
        message: "something wrong"
      }
    end
  end

  def new
    @notification = Notifications.new()
  end

  def destory
    @norification.destroy
  end

  def update
    if @notification.update(notif_params)
      redirect_to @notification
    end
  end

  def edit
  end

  private

  def find_notification
    @notification = Notifications.find_by(params[:id])
  end

  def notif_params
    params.require(:notification).permit(:type, :title, :content, :last_sent_at)
  end
end
