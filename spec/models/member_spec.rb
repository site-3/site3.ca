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

  describe "#rfid=" do
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

  describe "#to_tsv_line" do
    subject { build(:member, rfid: "testrfid", email: "build@example.com", notes: "Grouped with Other Person") }
    its(:to_tsv_line) { is_expected.to eq("#{subject.name}\t#{subject.email}\tAssociate\t9999\t12\t#{subject.stripe_id}\t#{subject.rfid}\tGrouped with Other Person") }
  end

  describe "#to_builder" do
    subject { build(:member, rfid: "testrfid", email: "build@example.com") }
    its(:to_builder) { is_expected.to eq({rfid: "testrfid", email: "build@example.com"}) }
  end

  describe "#stripe_customer" do
    before { StripeMock.start }
    after { StripeMock.stop }

    let!(:stripe_helper) { StripeMock.create_test_helper }

    context "strip_id is nil" do
      subject { FactoryGirl.create(:member, stripe_id: nil) }

      it "raises" do
        expect { subject.stripe_customer }.to raise_error
      end
    end

    context "stripe_customer exists" do
      let!(:stripe_customer) { Stripe::Customer.create }

      subject { FactoryGirl.create(:member, stripe_id: stripe_customer.id) }

      its(:stripe_customer) { is_expected.to be_present }
    end
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
