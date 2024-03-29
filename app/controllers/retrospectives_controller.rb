class RetrospectivesController < ApplicationController

  def new
    render layout: 'landing'
  end

  def create
    retrospective_data = retrospective_params
    owner_name = retrospective_data.delete(:owner_name)
    owner_name = 'Scrum Master' if owner_name == ''

    retrospective_data[:name] = 'Rumble in the jungle' if retrospective_data[:name] == ''

    retrospective = Retrospective.create!(retrospective_data.merge(public_key: SecureRandom.urlsafe_base64))

    status = Status.create!({ :status_type => Status::INVITE_USERS,
                              :retrospective_id => retrospective.id
                            })

    status.update_attribute(:start_time, Time.now)

    retrospective.update_attribute(:current_status_id, status.id)

    user = retrospective.users.create!(:name => owner_name, color: COLORS.sample)

    add_user_to_retro(retrospective, user.id, true)

    redirect_to retrospective_path(retrospective.public_key)
  end

  def show

  end

  def summary
    respond_to do |format|
      format.pdf do
        render :pdf => "kaigi_#{current_retro.public_key}"
      end
    end
  end

  private

  def retrospective_params
    params.require(:retrospective).permit(:name, :owner_name, :public_key)
  end

end