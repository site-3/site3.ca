RSpec.describe Member, type: :model do
  context "validations" do
    context "without name" do
      subject { build(:member, name: nil) }
      its(:valid?) { is_expected.to eq(false) }
    end

    context "without email" do
      subject { build(:member, email: nil) }
      its(:valid?) { is_expected.to eq(false) }
    end
  end

  describe ".rfid=" do
    context "with non downcased rfid" do
      subject { create(:member, rfid: "DEADBEEF") }
      its(:rfid) { is_expected.to eq("deadbeef") }
    end
  end
end
