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
end