require 'rails_helper'

RSpec.describe User, type: :model do
  context "Validations" do
    context "Attributes" do
      it {should validate_presence_of(:name)}
      it {should validate_presence_of(:email)}
    end
  end
end
