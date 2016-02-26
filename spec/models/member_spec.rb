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

    context "with non downcased rfid" do
      let!(:existing_member) { create(:member, rfid: "DEADBEEF") }

      subject { build(:member, rfid: "deadbeef") }
      its(:valid?) { is_expected.to eq(false) }
    end
  end

  describe "#create_from_member_application" do
    subject { described_class.create_from_member_application(member_application) }

    context "with only required attributes" do
      let!(:member_application) { FactoryGirl.create(:member_application,
                                                     name: "Test Person", email: "test@example.com",
                                                     stripe_id: "tok_1", rfid: nil)}

      it "creates a Member" do
        expect(subject.name).to eq("Test Person")
        expect(subject.email).to eq("test@example.com")
        expect(subject.stripe_id).to eq("tok_1")
        expect(subject.rfid).to eq(nil)
        expect(subject.enable_vending_machine).to eq(false)
        expect(subject.doorbot_enabled).to eq(true)
        expect(subject.password).to be_present
        expect(subject.valid?).to eq(true)
      end
    end

    context "with all attributes" do
      let!(:member_application) { FactoryGirl.create(:member_application,
                                                     name: "Test Person", email: "test@example.com",
                                                     stripe_id: "tok_1", enable_vending_machine: true, rfid: "deadbeef")}

      it "creates a Member" do
        expect(subject.name).to eq("Test Person")
        expect(subject.email).to eq("test@example.com")
        expect(subject.stripe_id).to eq("tok_1")
        expect(subject.rfid).to eq("deadbeef")
        expect(subject.enable_vending_machine).to eq(true)
        expect(subject.doorbot_enabled).to eq(true)
        expect(subject.password).to be_present
        expect(subject.valid?).to eq(true)
      end
    end
  end

  describe "#to_csv_line" do
    subject { build(:member, rfid: "testrfid", email: "build@example.com", notes: "Grouped with Other Person") }
    its(:to_csv_line) { is_expected.to eq("#{subject.name},#{subject.email},Associate,9999/12/1,#{subject.stripe_id},#{subject.rfid},Grouped with Other Person") }
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
