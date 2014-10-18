class StatusesSocketController < FayeRails::Controller

  channel '/statuses/start_current_phase' do
    monitor :publish do
      p '*******************************'
      p 'llegaaaaa 1'
      p data['status']
      p '********************************'
      Status.set_current_status(data['status'])

      begin
      StatusesSocketController.publish('/statuses/started_current_phase', nil)
      rescue Exception => e
        p e
      end
    end
  end

  channel '/statuses/end_current_phase' do
    monitor :publish do
      p '*******************************'
      p 'llegaaaaa 2'
      p data['status']
      p '********************************'
      Status.set_current_status(data['status'])

      StatusesSocketController.publish('/statuses/ended_current_phase', nil)
    end
  end
end