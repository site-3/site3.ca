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

  describe "#create_from_member_application" do
    let!(:member_application) { FactoryGirl.create(:member_application, name: "Test Person", email: "test@example.com", rfid: "deadbeef", stripe_id: "tok_1", enable_vending_machine: true)}

    it "creates a Member" do
      member = described_class.create_from_member_application(member_application)
      expect(member.name).to eq("Test Person")
      expect(member.email).to eq("test@example.com")
      expect(member.rfid).to eq("deadbeef")
      expect(member.stripe_id).to eq("tok_1")
      expect(member.enable_vending_machine).to eq(true)
      expect(member.doorbot_enabled).to eq(true)
    end
  end

  describe ".to_builder" do
    subject { build(:member, rfid: "testrfid", email: "build@example.com") }
    its(:to_builder) { is_expected.to eq({rfid: "testrfid", email: "build@example.com"}) }
  end

  context "scopes" do
    describe "#doorbot_enabled" do
      let!(:member_doorbot_disabled) { FactoryGirl.create(:member, doorbot_enabled: false) }
      let!(:member_doorbot_enabled) { FactoryGirl.create(:member, doorbot_enabled: true) }

      subject { described_class.doorbot_enabled }

      it { is_expected.to include(member_doorbot_enabled) }
      it { is_expected.not_to include(member_doorbot_disabled) }
    end
  end
end
