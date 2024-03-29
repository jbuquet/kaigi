class StickiesSocketController < FayeRails::Controller

  observe Sticky, :after_create do |sticky|
    data = sticky.attributes
    data[:user] = sticky.user.attributes
    StickiesSocketController.publish("/retrospectives/#{sticky.retrospective.id}/stickies/created",
                                     data)
  end

  observe Sticky, :after_destroy do |sticky|
    StickiesSocketController.publish("/retrospectives/#{sticky.retrospective.id}/stickies/deleted",
                                     sticky.attributes)
  end

  channel '/stickies/create' do
    monitor :publish do
      Sticky.create!(data['sticky'])
    end
  end

  channel '/stickies/delete' do
    monitor :publish do
      Sticky.destroy(data['id'])
    end
  end

end