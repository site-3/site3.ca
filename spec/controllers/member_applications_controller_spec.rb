require 'stripe_mock'

RSpec.describe MemberApplicationsController, type: :controller do
  let(:stripe_helper) { StripeMock.create_test_helper }
  before { StripeMock.start }
  after { StripeMock.stop }

  describe "#new" do
    def go!
      post :new
    end

    it "responds ok" do
      go!
      expect(response).to be_ok
    end
  end

  describe "#create" do
    def go!(params)
      post :create, params: params
    end

    context "with all required params" do
      let(:stripe_payment_token) { nil }
      let(:member_application) { FactoryGirl.build(:member_application, stripe_payment_token: stripe_payment_token) }
      let(:member_application_params) do
        {
          member_application: {
            name: member_application.name,
            email: member_application.email,
            stripe_payment_token: member_application.stripe_payment_token,
            enable_vending_machine: true,
            rfid: 'deadbeef',
          }
        }
      end

      it "creates a MemberApplication" do
        expect{ go!(member_application_params) }.to change(MemberApplication, :count).by(1)
      end

      it "sends an email" do
        expect(MemberApplicationMailer).to receive(:application_submitted).and_call_original
        expect { go!(member_application_params) }.to change(ActionMailer::Base.deliveries, :size).by(1)
      end

      context "with a stripe_payment_token" do
        let(:stripe_payment_token) { stripe_helper.generate_card_token }

        it "creates a Stripe::Customer" do
          expect(Stripe::Customer).to receive(:create).with({
            email: member_application.email,
            description: member_application.name,
            source: member_application.stripe_payment_token,
          }).and_call_original

          go!(member_application_params)

          expect(MemberApplication.last.stripe_id).to be_present
        end
      end

      it "redirects to root_path" do
        go!(member_application_params)

        expect(response).to redirect_to(root_path)
      end

      context "with json format" do
        before do
          @request.headers['Accept'] = 'application/json'
        end

        it "returns appropriate json" do
          go!(member_application_params)

          expect(response).to be_ok
          response_json = JSON.parse(response.body).deep_symbolize_keys
          expect(response_json).to eq({success: true})
        end
      end
    end

    context "with missing params" do
      let(:member_application_params) do
        {
          member_application: {
            name: "Test Person"
          }
        }
      end

      it "does not create a MemberApplication" do
        expect{ go!(member_application_params) }.not_to change(MemberApplication, :count)
      end

      it "does not create a Stripe::Customer" do
        expect(Stripe::Customer).not_to receive(:create)

        go!(member_application_params)
      end

      it "renders new" do
        go!(member_application_params)

        expect(response).to be_ok
        expect(response).to render_template(:new)
      end

      context "with json format" do
        before do
          @request.headers['Accept'] = 'application/json'
        end

        it "returns appropriate json" do
          go!(member_application_params)

          expect(response.status).to eq(522)
          response_json = JSON.parse(response.body).deep_symbolize_keys
          expect(response_json).to eq({
            success: false,
            errors: {
              email: ["can't be blank"]
            }
          })
        end
      end
    end
  end
end
