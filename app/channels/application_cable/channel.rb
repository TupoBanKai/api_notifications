module ApplicationCable
  class Channel < ActionCable::Channel::Base
    after_subscribe :connection_monitor

    CONNECTION_TIMEOUT = 5.seconds
    CONNECTION_PING_INTERVAL = 2.seconds


    periodically every: CONNECTION_PING_INTERVAL do
      @driver&.ping
      if Time.now - @_last_request_at > @_timeout
        connection.disconnect
      end
    end

    def connection_monitor
      @_last_request_at ||= Time.new
      @_timeout = CONNECTION_TIMEOUT

      @driver = connection.instance_variable_get('@websocket').possible?&.instance_variable_get('@driver')
      @driver.on(:pong) { @_last_request_at = Time.now }
    end
  end
end
