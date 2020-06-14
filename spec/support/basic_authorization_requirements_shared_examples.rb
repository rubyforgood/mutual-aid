RSpec.shared_examples 'redirects without authorization' do
  context "when not signed-in" do
    it { is_expected.to redirect_to(new_user_session_path) }
  end
end

RSpec.shared_examples 'successful with basic user authorization' do |user_id|
  let(:user) { User.where(id: user_id).first || create(:user) }

  context "when signed-in as a user" do
    before(:each) { sign_in(user) }

    it "renders successfully" do
      subject
      expect(response).to be_successful
    end
  end
end

RSpec.shared_examples 'successful with admin user authorization' do
  let(:user) { User.admin_role.first || create(:user, :admin) }
  before(:each) { sign_in(user) }

  it "renders successfully" do
    subject
    expect(response).to be_successful
  end
end

RSpec.shared_examples 'successful with SysAdmin user authorization' do
  let(:user) { User.sys_admin_role.first || create(:user, :sys_admin) }
  before(:each) { sign_in(user) }

  it "renders successfully" do
    subject
    expect(response).to be_successful
  end
end

RSpec.shared_examples 'disallowed behavior as' do |user_factory_params|
  context "while signed-in with: #{user_factory_params.join(', ')}" do
    it "disallows access" do
      sign_in(create(*user_factory_params))
      subject
      expect(response).not_to be_successful
    end
  end
end

# Meta-example using common behaviors
RSpec.shared_examples "basic user authorization required" do |user_id|
  include_examples "redirects without authorization"
  include_examples "successful with basic user authorization", user_id.presence
end