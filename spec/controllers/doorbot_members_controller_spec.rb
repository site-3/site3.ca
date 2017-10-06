RSpec.describe DoorbotMembersController, type: :controller do
  let!(:member_doorbot_disabled) { FactoryGirl.create(:member, doorbot_enabled: false) }
  let!(:member_doorbot_enabled) { FactoryGirl.create(:member, doorbot_enabled: true) }

  describe "#index" do
    def go!(token)
      get :index, params: {token: token}
    end

    context "with correct token" do
      let(:token) { Rails.application.secrets.doorbot_members_token }

      context "for an known user" do
        it "returns json" do
          go!(token)
          expect(response.content_type).to eq('application/json')
        end

        it "returns json" do
          go!(token)
          response_json = JSON.parse(response.body)
          expect(response_json).to eq([member_doorbot_enabled.to_builder.target!])
        end
      end
    end

    context "with an incorrect token" do
      let(:token) { "incorrect_token" }

      it "does not return members" do
        expect { go!(token) }.to raise_error(RuntimeError)
      end
    end
  end
end
