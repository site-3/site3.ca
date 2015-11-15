RSpec.describe MemberMailer, type: :mailer do
  let(:member) { FactoryGirl.create(:member) }

  describe "welcome_email" do
    subject { MemberMailer.send(:welcome_email, member) }

    its(:subject) { is_expected.to eq("Welcome to Site 3!") }
    its(:to) { is_expected.to include(member.email) }
    its(:from) { is_expected.to include("info@site3.ca") }
  end
end
