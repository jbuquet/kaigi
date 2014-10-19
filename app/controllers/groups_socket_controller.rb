class GroupsSocketController < FayeRails::Controller

  observe Group, :after_create do |group|
    data = group.attributes

    if data['name'] != 'General'
      data[:sticky_ids] = group.sticky_ids
      GroupsSocketController.publish("/retrospectives/#{group.retrospective.id}/groups/created",
                                     data)
    end
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

  channel '/groups/vote' do
    monitor :publish do
      group = Group.find_by_id(data['id'])
      user = User.find_by_id(data['user_id'])

      if group && user && user.has_votes_left?
        Group.update_counters group, :votes => 1
        User.update_counters user, :used_votes => 1

        group.reload
        user.reload

        user_data = user.attributes
        user_data[:remaining_votes] = user.remaining_votes

        GroupsSocketController.publish("/retrospectives/#{group.retrospective.id}/groups/voted",
                                       { group: group, user: user_data })
      end
    end
  end

  channel '/groups/add_sticky' do
    monitor :publish do
      sticky = Sticky.find_by_id(data['sticky_id'])

      if sticky && !sticky.group_id
        sticky.update_attribute('group_id', data['id'])

        GroupsSocketController.publish("/retrospectives/#{sticky.retrospective.id}/groups/sticky_added",
                                       { group: sticky.group, sticky: sticky })

      end
    end
  end

  channel '/groups/remove_sticky' do
    monitor :publish do
      sticky = Sticky.find_by_id(data['sticky_id'])
      group = sticky.group

      if sticky && group
        sticky.update_attribute('group_id', nil)

        GroupsSocketController.publish("/retrospectives/#{sticky.retrospective.id}/groups/sticky_removed",
                                       { group: group, sticky: sticky })
      end
    end
  end

  channel '/groups/rename' do
    monitor :publish do
      group = Group.find_by_id(data['id'])

      if group
        group.update_attribute('name', data['name'])

        GroupsSocketController.publish("/retrospectives/#{sticky.retrospective.id}/groups/renamed",
                                       { group: group })

      end
    end
  end

end