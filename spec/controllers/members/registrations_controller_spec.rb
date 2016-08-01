RSpec.describe Members::RegistrationsController, type: :controller do
  let(:password) { Faker::Internet.password }

  describe "#create" do

    before do
      set_devise_mapping(:member)
    end

    def go!(params)
      post :create, params
    end

    let(:params) do
      {
        member: {
          email: "new-email@example.com",
          name: "Test person",
          enable_vending_machine: "1",
          password: password,
        }
      }
    end

    it "creates user with allowed params" do
      go! params
      member = Member.last

      expect(member.email).to eq("new-email@example.com")
      expect(member.name).to eq("Test person")
      expect(member.enable_vending_machine).to eq(true)
      expect(response).to redirect_to(edit_member_registration_path)
    end
  end

  describe "#update" do
    let!(:member) { create(:member, password: password) }

    before do
      set_devise_mapping(:member)
      sign_in member
    end

    def go!(params)
      put :update, params
    end

    let(:params) do
      {
        member: {
          email: "new-email@example.com",
          name: "Test person",
          enable_vending_machine: "1",
        }
      }
    end

    it "updates all allowed params" do
      go! params
      member.reload

      expect(member.email).to eq("new-email@example.com")
      expect(member.name).to eq("Test person")
      expect(member.enable_vending_machine).to eq(true)
      expect(response).to redirect_to(edit_member_registration_path)
    end
  end
end
