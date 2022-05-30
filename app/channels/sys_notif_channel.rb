require 'securerandom'
require 'benchmark'

class SysNotifChannel < ApplicationCable::Channel

  def subscribed
    stream_from "sys_notif_#{ uuid }", -> (json) {
      notif_preparation ActiveSupport::JSON.decode(json) do |params|
        transmit params
      end
    }
  end

  def unsubscribed
  end

  def send_notification
    ActiveCable.broadcast_for(uuid, -> (json) {
      transmit find_notification(:saccess)
    })
  end

  private

  def notif_preparation(params)
    notif = find_notification("success")
    notif.update_column(:last_sent_at, Time.now)

    ActiveSupport::Notifications.instrument :performance, chat: "sys_notif_#{ uuid }"

    yield params if block_given?
    params
  end

  def find_notification(params)
    Notifications.find_by(type: params)
  end
end
