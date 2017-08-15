class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if current_user
      if current_user.first_name.present?
        redirect_to companies_path
      else
        redirect_to edit_profile_path
      end
    end
  end
end
