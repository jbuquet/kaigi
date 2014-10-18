class StatusesSocketController < FayeRails::Controller

  channel '/statuses/set_time_next_phase' do
    monitor :publish do
      Status.set_status(data['status'])

      StatusesSocketController.publish('/statuses/to_start_next_phase', nil)
    end
  end

  channel '/statuses/start_current_phase' do
    monitor :publish do
      Status.start_current_status(data['retrospective_id'])

      StatusesSocketController.publish('/statuses/started_current_phase', nil)
    end
  end

  channel '/statuses/end_current_phase' do
    monitor :publish do
      Status.end_current_status(data['retrospective_id'])

      StatusesSocketController.publish('/statuses/ended_current_phase', nil)
    end
  end
end