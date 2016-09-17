require 'rails_helper'

RSpec.describe User do

  describe 'Associations' do
    it { should belong_to(:role)}
  end

  describe 'Validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_presence_of :username }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_uniqueness_of(:username).case_insensitive }
  end

end
