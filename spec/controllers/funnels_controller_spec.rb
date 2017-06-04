require 'rails_helper'
require 'rake'

describe FunnelsController, :type => :controller do
  describe "GET index" do

    let(:start_date) { "2015-12-01" }
    let(:end_date) { "2015-12-28" }

    subject { get :index, start_date: start_date, end_date: end_date, format: :json }

    before  do
      Applicant.create!(first_name: "Bhanu Bhakta", last_name: "Sigdel", email: "bsbhanu@gmail.com", phone: 641-451-3401, phone_type: Applicant::PHONE_TYPES[0], workflow_state: Applicant::WORKFLOW_STATES[0], region: Applicant::REGIONS[2], updated_at: DateTime.new(2015, 12, 02))

      Applicant.create!(first_name: "Pradeep", last_name: "Bogati", email: "bsbhan@gmail.com", phone: 641-451-3402, phone_type: Applicant::PHONE_TYPES[1], workflow_state: Applicant::WORKFLOW_STATES[1], region: Applicant::REGIONS[2], updated_at: DateTime.new(2015, 12, 10))

      Applicant.create!(first_name: "Bibas", last_name: "Singh", email: "bsbha@gmail.com", phone: 641-451-3403, phone_type: Applicant::PHONE_TYPES[2], workflow_state: Applicant::WORKFLOW_STATES[3], region: Applicant::REGIONS[2], updated_at: DateTime.new(2015, 12, 15))

      Applicant.create!(first_name: "Pukar", last_name: "Mainali", email: "bsbh@gmail.com", phone: 641-451-3404, phone_type: Applicant::PHONE_TYPES[3], workflow_state: Applicant::WORKFLOW_STATES[3], region: Applicant::REGIONS[2], updated_at: DateTime.new(2015, 12, 20))

      Rake::Task['funnel:summarize_all'].invoke
    end

    context 'there exists records in the provided date range' do
      
      before do
        subject
      end

      it "should return json with two buckets" do
        results = JSON.parse response.body
        expect(results.count).to eq 3
      end
      
      it "should respond with http success" do
        expect(response.status).to be 200
      end
    end

    context 'start date is greater than end_date' do
      let(:start_date) { "2015-12-28" }
      let(:end_date) { "2015-12-01" }

      before do
        subject
      end

      it 'should respond with http success' do
        expect(response.status).to be 422
      end

      it 'returns proper error message' do
        result = JSON.parse response.body
        expect(result['message']).to eq("start_date cannot be greater than end_date")
      end
    end
  end
end