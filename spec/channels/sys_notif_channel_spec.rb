require 'rails_helper'
require 'securerandom'

describe SysNotifChannel do
  let(:uuid) { SecureRandom.uuid }

  before do
    stub_connection uuid: uuid
  end

  describe '#subscribe' do
    it 'confirm the subscription' do
      subscribe

      expect(subscription).to be_confirmed
      expect(subscription).to have_stream_from("sys_notif_#{uuid}")
    end
  end

  describe '#unsubscribe' do
    let(:uuid) { SecureRandom.uuid }

    before { subscribe }

    it 'cancels the subscription and disconnects the connection' do
      unsubscribe

      expect(disconnect).to be_truthy
    end
  end
end
