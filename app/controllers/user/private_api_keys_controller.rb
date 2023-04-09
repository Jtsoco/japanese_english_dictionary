class User::PrivateApiKeysController < ApplicationController
  before_action :authenticate_user!
  def update
    authorize current_user
    if current_user.update(private_api_key: SecureRandom.hex)
      redirect_to user_path(current_user), notice: "API Updated"
    else
      # TODO test the path to make sure it works
      redirect_to user_path(current_user), alert: "There was an error: #{current_user.errors.full_messages.to_sentence}"
    end
  end
end
