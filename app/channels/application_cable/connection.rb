require 'securerandom'

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :uuid

    def connect
      self.uuid = SecureRandom.uuid
    end

    def disconnect
      ActionCable.server.remote_connections.where(uuid: uuid).disconnect
    end
  end
end
