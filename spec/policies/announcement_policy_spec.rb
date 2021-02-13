require 'rails_helper'

# FIXME: remove or consolidate this block once #834 is resolved
RSpec.configure do
  Pundit::Matchers.configure do |config|
    config.user_alias = :acting_user
  end
end

RSpec.describe AnnouncementPolicy do
  let(:context) { Context.new user: user }
  let(:announcement) { double :announcement }

  let(:approved_announcement) { create :announcement, is_approved: true }
  let(:pending_announcement)  { create :announcement, is_approved: false }
  let(:create_announcements)  { [approved_announcement, pending_announcement] }

  let(:policy_scope) { AnnouncementPolicy::Scope.new(context, Announcement.all).resolve }

  subject { AnnouncementPolicy.new context, announcement }

  context 'guest user' do
    let(:user) { nil }

    it { is_expected.to permit_actions %i[show new create] }
    it { is_expected.to forbid_actions %i[edit update destroy] }
    it { is_expected.to forbid_mass_assignment_of :is_approved }

    it 'is only shown approved announcements' do
      create_announcements
      expect(policy_scope).to match [approved_announcement]
    end
  end

  context 'authenticated user' do
    let(:user) { build :user }

    it { is_expected.to permit_actions %i[show new create] }
    it { is_expected.to forbid_actions %i[edit update destroy] }
    it { is_expected.to forbid_mass_assignment_of :is_approved }

    it 'is only shown approved announcements' do
      create_announcements
      expect(policy_scope).to match [approved_announcement]
    end
  end

  context 'admin user' do
    let(:user) { build :user, :admin }

    it { is_expected.to permit_actions %i[show new create edit update destroy] }
    it { is_expected.to permit_mass_assignment_of :is_approved }

    it 'is shown all announcements' do
      create_announcements
      expect(policy_scope).to match [approved_announcement, pending_announcement]
    end
  end
end
