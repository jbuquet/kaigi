class ActionItemsSocketController < FayeRails::Controller

  observe ActionItem, :after_create do |action_item|
    ActionItemsSocketController.publish("/retrospectives/#{action_item.retrospective.id}/action_items/created",
                                        action_item.attributes)
  end

  observe ActionItem, :after_destroy do |action_item|
    ActionItemsSocketController.publish("/retrospectives/#{action_item.retrospective.id}/action_items/deleted",
                                        action_item.attributes)
  end

  channel '/action_items/create' do
    monitor :publish do
      ActionItem.create!(data['action_item'])
    end
  end

  channel '/action_items/delete' do
    monitor :publish do
      ActionItem.destroy(data['id'])
    end
  end

end