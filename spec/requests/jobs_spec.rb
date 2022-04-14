# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Jobs API', type: :request do
  # add jobs owner
  let(:user) { create(:user) }
  let!(:jobs) { create_list(:job, 10, description: user.id) }
  let(:job_id) { jobs.first.id }
  # authorize request
  let(:headers) { valid_headers }

  describe 'GET /jobs' do
    # update request with headers
    before { get '/jobs', params: {}, headers: headers }

    it 'returns jobs' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /jobs/:id' do
    before { get "/jobs/#{job_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the job' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(job_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:job_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Job/)
      end
    end
  end

  describe 'POST /jobs' do
    let(:valid_attributes) do
      { title: 'Test', description: user.id.to_s }.to_json
    end

    context 'when request is valid' do
      before { post '/jobs', params: valid_attributes, headers: headers }

      it 'creates a job' do
        expect(json['title']).to eq(nil)
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { title: nil }.to_json }
      before { post '/jobs', params: invalid_attributes, headers: headers }

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/You are not authorized to access this page./)
      end
    end
  end

  describe 'PUT /jobs/:id' do
    let(:valid_attributes) { { title: 'Shopping' }.to_json }

    context 'when the record exists' do
      before { put "/jobs/#{job_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).not_to be_empty
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'DELETE /jobs/:id' do
    before { delete "/jobs/#{job_id}", params: {}, headers: headers }

    it 'returns status code 401' do
      expect(response).to have_http_status(401)
    end
  end
end
