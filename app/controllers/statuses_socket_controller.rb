class StatusesSocketController < FayeRails::Controller

  channel '/statuses/set_time_next_phase' do
    monitor :publish do
      Status.set_status(data['status'])

      begin
      StatusesSocketController.publish('/statuses/to_start_next_phase', nil)
      rescue Exception => e
        p e
      end
    end
  end
end