RSpec.describe Admin::MemberApplicationsController, type: :controller do
  let!(:member_application) { FactoryGirl.create(:member_application) }

  before { sign_in FactoryGirl.create(:member, :admin) }

  describe "#index" do
    def go!
      get :index
    end

    it "responds ok" do
      go!
      expect(response).to be_ok
    end

    it "includes member applications" do
      go!
      expect(response.body).to include(member_application.name)
    end

    context "with a non admin member" do
      before { sign_in FactoryGirl.create(:member) }

      it "blocks unauthenticated access" do
        expect { go! }.to raise_error
      end
    end
  end

  describe "#approve" do
    def go!(member_application)
      post :approve, {member_application_id: member_application.id}
    end

    it "creates a Member" do
      expect{ go!(member_application) }.to change(Member, :count).by(1)
    end

    it "updates the MemberApplication.member" do
      go!(member_application)

      member_application.reload
      expect(member_application.member).to eq(Member.last)
    end

    context "with a non admin member" do
      before { sign_in FactoryGirl.create(:member) }

      it "blocks unauthenticated access" do
        expect { go! }.to raise_error
      end
    end
  end
end
