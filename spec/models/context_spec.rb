require 'spec_helper'

RSpec.describe Context do
  describe 'initialization' do
    it 'allows keyword init' do
      context = Context.new user: double(:user)
      expect(context.user).to be_present
    end

    it 'allows args to be omitted' do
      context = Context.new
      expect(context.user).to be_nil
    end
  end

  describe 'lazy, memoized, overridable readers' do
    let(:current_settings) { double :current_settings }
    let(:system_setting) { class_double('SystemSetting').as_stubbed_const }
    let(:context) { Context.new }

    it 'is lazy' do
      expect(system_setting).to receive(:current_settings) { current_settings }
      expect(context.system_settings).to be current_settings
    end

    it 'is memoized' do
      expect(system_setting).to receive(:current_settings).once { current_settings }
      context.system_settings
      context.system_settings
    end

    it 'can be overriden' do
      expect(system_setting).to receive(:current_settings).never
      context.system_settings = double(:override)
      context.system_settings
    end
  end
end
