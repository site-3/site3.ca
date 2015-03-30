RSpec.describe MemberApplicationsController, type: :controller do
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
    context "with all required params" do
      let(:member_application) { FactoryGirl.build(:member_application) }
      let(:member_application_params) do
        {
          member_application: {
            name: member_application.name,
            email: member_application.email,
          }
        }
      end

      def go!(params)
        post :create, params
      end

      it "redirects to root_path" do
        go!(member_application_params)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
