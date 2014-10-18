class RetrospectivesController < ApplicationController

  def new
    @retros = Retrospective.all
    render layout: 'landing'
  end

  def create
    retrospective_data = retrospective_params
    owner_name = retrospective_data.delete(:owner_name)

    retrospective = Retrospective.create!(retrospective_data.merge(public_key: SecureRandom.urlsafe_base64))

    status = Status.create!({ :status_type => Status::INVITE_USERS,
                              :retrospective_id => retrospective.id
                            })

    status.update_attribute(:start_time, Time.now)

    retrospective.update_attribute(:current_status_id, status.id)

    user = retrospective.users.create!(:name => owner_name, color: COLORS.sample)

    session[:is_manager] = true
    add_user_to_retro(retrospective, user.id)

    redirect_to retrospective_path(retrospective.public_key)
  end

  def show

  end

  private

  def retrospective_params
    params.require(:retrospective).permit(:name, :owner_name, :public_key)
  end

end