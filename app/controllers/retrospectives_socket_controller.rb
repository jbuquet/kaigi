class RetrospectivesSocketController < FayeRails::Controller

  channel '/retrospectives/set_retro_votes' do
    monitor :publish do
      Retrospective.set_max_votes(data['votes_data'])
    end
  end
end