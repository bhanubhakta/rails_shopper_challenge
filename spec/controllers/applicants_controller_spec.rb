require 'rails_helper'

describe ApplicantsController do

  context "GET new" do
    subject { get :new }
    before  { subject }

    it "returns http success" do
      expect(response.status).to be 200
    end

    it "renders the  template" do
      expect(response).to render_template :new
    end
  end

  context "POST create" do
    context "With valid params" do
      let(:params) do 
        { 
          first_name: "Bhanu", 
          last_name: "Sigdel", 
          email: "bsbhanu169@gmail.com", 
          phone: "9849021744", 
          phone_type: "Iphone", 
          region: "CA Bay Area" 
        }
      end

      subject { post :create, applicant:  params }

      it "creates a new applicant in the database" do
        expect{ subject }.to change { Applicant.count}.by 1
      end
    end
  end

  context 'post authorize' do
    let(:applicant) { Applicant.create(first_name: "Bhanu", last_name: "Sigdel", email: "bsbhanu169@gmail.com", phone: "9849021744", phone_type: "Iphone", region: "CA Bay Area") }

    subject { patch :authorize, id: applicant.id }

    before {
      session[:email] = applicant.email
      subject
    }

    it 'authorizes the applicant' do
      expect(applicant.reload.workflow_state).to eq('quiz_started')
    end
  end
end