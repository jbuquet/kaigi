class StatusesSocketController < FayeRails::Controller

  channel '/statuses/start_current_phase' do
    monitor :publish do
      Status.set_current_status(data['status'])

      StatusesSocketController.publish('/statuses/started_current_phase', nil)
    end
  end

  channel '/statuses/end_current_phase' do
    monitor :publish do
      Status.set_current_status(data['status'])

      StatusesSocketController.publish('/statuses/ended_current_phase', nil)
    end
  end
end