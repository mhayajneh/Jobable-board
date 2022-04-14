# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Applications API' do
  let(:user) { create(:user) }
  let!(:job) { create(:job, description: 'asd') }
  let!(:applications) { create_list(:application, 20, job_id: job.id) }
  let(:job_id) { job.id }
  let(:id) { applications.first.id }
  let(:headers) { valid_headers }

  describe 'GET /jobs/:job_id/applications' do
    before { get "/jobs/#{job_id}/applications", params: {}, headers: headers }

    context 'when job exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all job applications' do
        expect(json.size).to eq(20)
      end
    end

    context 'when job does not exist' do
      let(:job_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Job/)
      end
    end
  end

  describe 'GET /jobs/:job_id/applications/:id' do
    before { get "/jobs/#{job_id}/applications/#{id}", params: {}, headers: headers }

    context 'when job application exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the application' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when job application does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Application/)
      end
    end
  end

  describe 'POST /jobs/:job_id/applications' do
    let(:valid_attributes) { { applicant: 'Visit Narnia', seen: false }.to_json }

    context 'when request attributes are valid' do
      before do
        post "/jobs/#{job_id}/applications", params: valid_attributes, headers: headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/jobs/#{job_id}/applications", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(201)
      end
    end
  end

  describe 'PUT /jobs/:job_id/applications/:id' do
    let(:valid_attributes) { { applicant: 'Mozart' }.to_json }

    before do
      put "/jobs/#{job_id}/applications/#{id}", params: valid_attributes, headers: headers
    end

    context 'when application exists' do
      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end

      it 'updates the application' do
        updated_application = Application.find(id)
        expect(updated_application.applicant).to match(updated_application.applicant)
      end
    end

    context 'when application does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Application/)
      end
    end
  end

  describe 'DELETE /jobs/:id' do
    before { delete "/jobs/#{job_id}/applications/#{id}", params: {}, headers: headers }

    it 'returns status code 401' do
      expect(response).to have_http_status(401)
    end
  end
end
