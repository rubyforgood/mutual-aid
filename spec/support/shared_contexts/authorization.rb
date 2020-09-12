RSpec.shared_context "acting as signed-in user" do
  let(:acting_user) { FactoryBot.create(:user) }
end 

RSpec.shared_context "acting as sysadmin" do
  let(:acting_user) { FactoryBot.create(:user, :sys_admin) }
end

RSpec.shared_context "acting as admin" do
  let(:acting_user) { FactoryBot.create(:user, :admin) }
end

RSpec.shared_context "signed in as generic user" do
  include_context "acting as signed-in user"
  before do
    sign_in(acting_user)
  end
end

RSpec.shared_context "signed in as sysadmin" do
  include_context "acting as sysadmin"
  before do
    sign_in(acting_user)
  end
end

RSpec.shared_context "signed in as admin" do
  include_context "acting as admin"
  before do
    sign_in(acting_user)
  end
end