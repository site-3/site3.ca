RSpec.describe Members::SessionsController, type: :controller do
  describe "#create" do
    let(:password) { Faker::Internet.password }
    let!(:member) { create(:member, password: password) }

    before { set_devise_mapping(:member) }

    def go!(params)
      post :create, params
    end

    context "with correct password" do
      let(:params) do
        {
          member: {
            email: member.email,
            password: password,
          }
        }
      end

      it "redirects to correct page" do
        post :create, params
        expect(response).to redirect_to(edit_member_registration_path)
      end
    end
  end
end
