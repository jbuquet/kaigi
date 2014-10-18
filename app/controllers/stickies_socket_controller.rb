class StickiesSocketController < FayeRails::Controller

  observe Sticky, :after_create do |sticky|
    StickiesSocketController.publish('/stickies/created', sticky.attributes)
  end

  observe Sticky, :after_destroy do |sticky|
    StickiesSocketController.publish('/stickies/deleted', sticky.attributes)
  end

  channel '/stickies/create' do
    monitor :publish do
      p data
      Sticky.create!(data['sticky'])
    end
  end

  channel '/stickies/delete' do
    monitor :publish do
      Sticky.destroy(data['id'])
    end
  end

end