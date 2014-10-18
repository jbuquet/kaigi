class StatusesSocketController < FayeRails::Controller

  channel '/statuses/start_current_phase' do
    monitor :publish do
      Status.start_current_status(data['status'])

      begin
      StatusesSocketController.publish('/statuses/started_current_phase', nil)
      rescue Exception => e
        p e
      end
    end
  end

  channel '/statuses/end_current_phase' do
    monitor :publish do
      Status.end_current_status(data['retrospective_id'])

      StatusesSocketController.publish('/statuses/ended_current_phase', nil)
    end
  end
end