RSpec.describe Member, type: :model do
  context "validations" do
    context "must have a name" do
      subject { build(:member, name: nil) }
      its(:valid?) { is_expected.to eq(false) }
    end

    context "must have an email" do
      subject { build(:member, email: nil) }
      its(:valid?) { is_expected.to eq(false) }
    end
  end
end
