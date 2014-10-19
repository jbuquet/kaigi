class UsersSocketController < FayeRails::Controller

  USERS = {}

  channel '/users/join' do
    monitor :publish do
      user = User.find_by_id((data['user'] || {})['id'])
      retrospective = user.try(:retrospective)

      if retrospective
        USERS[client_id] = user.id
        data = {
          user: user,
          users_count: retrospective.users.count
        }

        UsersSocketController.publish("/retrospectives/#{retrospective.id}/users/joined",
                                      data)
      end
    end

    # Uncomment this when we can make it work or delete and use ping approach.
    # monitor :unsubscribe do
    #   puts 'User left.'
    #
    #   user_id = USERS.delete(client_id)
    #   user = User.find_by_id(user_id)
    #   retrospective = user.try(:retrospective)
    #
    #   if retrospective
    #     UsersSocketController.publish("/retrospectives/#{retrospective.id}/users/left",
    #                                   user)
    #   end
    # end
  end

end