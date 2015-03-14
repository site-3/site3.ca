RSpec.describe Member, type: :model do
  context "validations" do
    context "must have a name" do
      subject { build(:member, name: nil) }
      its(:valid?) { should eq(false) }
    end

    context "must have an email" do
      subject { build(:member, email: nil) }
      its(:valid?) { should eq(false) }
    end
  end
end
