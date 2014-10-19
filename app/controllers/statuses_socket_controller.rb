class StatusesSocketController < FayeRails::Controller

  channel '/statuses/set_current_status' do
    monitor :publish do
      retrospective_id = data['status']['retrospective_id']

      Status.set_current_status(data['status'])

      StatusesSocketController.publish("/retrospectives/#{retrospective_id}/statuses/after_set_current_status", nil)
    end
  end
end