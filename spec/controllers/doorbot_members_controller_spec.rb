RSpec.describe DoorbotMembersController, type: :controller do
  describe "#index" do
    context "for an known user" do
      let!(:member_doorbot_disabled) { FactoryGirl.create(:member, doorbot_enabled: false) }
      let!(:member_doorbot_enabled) { FactoryGirl.create(:member, doorbot_enabled: true) }

      it "returns json" do
        get :index

        expect(response.content_type).to eq('application/json')
      end

      it "returns json" do
        get :index
        response_json = JSON.parse(response.body)

        expect(response_json).to eq([member_doorbot_enabled.to_builder.target!])
      end
    end
  end
end
