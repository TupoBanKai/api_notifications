module ApplicationCable
  class Channel < ActionCable::Channel::Base
    after_subscribe :connection_monitor

    CONNECTION_TIMEOUT = 5.seconds
    CONNECTION_PING_INTERVAL = 2.seconds


    periodically every: CONNECTION_PING_INTERVAL do
      transmit action: :ping, uuid: "#{uuid}"
      if Time.now - @_last_request_at > CONNECTION_TIMEOUT
        connection.disconnect
      end
    end

    def connection_monitor
      @_last_request_at ||= Time.new
    end
  end
end
