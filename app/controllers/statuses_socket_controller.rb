class StatusesSocketController < FayeRails::Controller

  channel '/statuses/set_current_status' do
    monitor :publish do
      retrospective_id = data['status']['retrospective_id']

      Status.set_current_status(data['status'])

      retrospective = Retrospective.find(retrospective_id)

      if retrospective.current_status.status_type == Status::SET_VOTE_GROUPS_TIMEBOX
        retrospective.create_general_group(retrospective_id)
      end

      StatusesSocketController.publish("/retrospectives/#{retrospective_id}/statuses/after_set_current_status", nil)
    end
  end
end