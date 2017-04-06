RSpec.describe ChargesController, type: :controller do
  describe "#create" do
    let!(:stripe_helper) { StripeMock.create_test_helper }
    before { StripeMock.start }
    after { StripeMock.stop }

    def go!(rfid, token=Rails.application.secrets.vending_machine_token)
      post :create, params: { rfid: rfid, token: token, format: :json }
    end

    context "for an unknown rfid" do
      let(:rfid) { "beadbeef" }

      it "fails" do
        expect(Rails.logger).to receive(:error).with(instance_of(ActiveRecord::RecordNotFound))
        expect(Rails.logger).to receive(:error).with(instance_of(Array))
        go!(rfid)
        expect(response.body).to eq({status: 1}.to_json)
      end
    end

    context "for an known rfid" do
      context "when enable_vending_machine is false" do
        let(:member) { create(:member, enable_vending_machine: false) }

        it "fails" do
          expect(Rails.logger).to receive(:error).with(instance_of(ActiveRecord::RecordNotFound))
          expect(Rails.logger).to receive(:error).with(instance_of(Array))
          go!(member.rfid)
          expect(response.body).to eq({status: 1}.to_json)
        end
      end

      context "when enable_vending_machine is true" do
        let(:member) { create(:member, enable_vending_machine: true) }

        context "with working card" do
          it "succeeds" do
            expect(Rails.logger).not_to receive(:error)
            go!(member.rfid)
            expect(response.body).to eq({status: 0}.to_json)
          end
        end

        context "with declined card" do
          it "fails" do
            StripeMock.prepare_card_error(:card_declined)
            expect(Rails.logger).to receive(:error).with(instance_of(Stripe::CardError))
            expect(Rails.logger).to receive(:error).with(instance_of(Array))
            go!(member.rfid)
            expect(response.body).to eq({status: 1}.to_json)
          end
        end

        context "when using incorrect rfid capitialization" do
          it "succeds" do
            go!(member.rfid.upcase)
            expect(response.body).to eq({status: 0}.to_json)
          end
        end

        context "with incorrect token" do
          let(:token) { "notavalidtoken" }
          it "fails" do
            expect(Rails.logger).to receive(:error).with(instance_of(RuntimeError))
            expect(Rails.logger).to receive(:error).with(instance_of(Array))
            go!(member.rfid, token=token)
            expect(response.body).to eq({status: 1}.to_json)
          end
        end
      end
    end
  end
end
