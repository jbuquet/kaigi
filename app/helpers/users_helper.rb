module UsersHelper

  def user_initial(user)
    (user.name[0] || '').upcase
  end

end