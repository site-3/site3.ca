RSpec.describe CardsController, type: :controller do
  let!(:stripe_helper) { StripeMock.create_test_helper }
  before { StripeMock.start }
  after { StripeMock.stop }

  describe "#create" do
    def go!(token)
      post :create, {id: token}
    end

    context "for an known user" do
      let(:member) { create(:member) }

      context "with a valid card token" do
        it "succeeds" do
          go!(stripe_helper.generate_card_token)
          expect(response).to be_redirect
        end
      end

      context "with declined card" do
        before :each do
          StripeMock.prepare_card_error(:card_declined, :create_card)
        end

        it "fails" do
          go!(stripe_helper.generate_card_token)
          expect(response).not_to be_ok
        end
      end
    end
  end
end
