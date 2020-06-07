module ControllerMacros
  def login_admin
    before(:each) do
      # request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in create(:user, :admin)
    end
  end

  def login_user
    before(:each) do
      # request.env["devise.mapping"] = Devise.mappings[:user]
      user = create(:user)
      sign_in user
    end
  end
end