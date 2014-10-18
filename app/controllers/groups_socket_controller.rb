class GroupsSocketController < FayeRails::Controller

  observe Group, :after_create do |group|
    GroupsSocketController.publish("/retrospectives/#{group.retrospective.id}/groups/created",
                                     group.attributes)
  end

  observe Group, :after_destroy do |group|
    GroupsSocketController.publish("/retrospectives/#{group.retrospective.id}/groups/deleted",
                                     group.attributes)
  end

  channel '/groups/create' do
    monitor :publish do
      Group.create!(data['group'])
    end
  end

  channel '/groups/delete' do
    monitor :publish do
      Group.destroy(data['id'])
    end
  end

end