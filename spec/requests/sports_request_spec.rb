require 'rails_helper'

RSpec.describe "Sports", type: :request do

  describe "GET /sports" do
    before(:each) do
      @sports = create_list(:sport, 3)
      get "/sports"
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    %i[id name victory_rule].each do |attr|
      it "displays #{attr}" do
        @sports.each do |sport|
          expect(response.body).to include(sport.send(attr).to_json)
        end
      end
    end
  end

  describe "GET /sports/:id" do
    context 'when the product exists' do
      before(:each) do
        @sport = create(:sport)
        get "/sports/#{@sport.id}"
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      %i[id name victory_rule].each do |attr|
        it "displays #{attr}" do
          expect(response.body).to include(@sport.send(attr).to_json)
        end
      end
    end

    context 'when the product do not exists' do
      it "returns http not found" do
        get "/sports/1"
        expect(response).to have_http_status(:not_found)
      end
    end
  end
  
  describe "POST /sports" do
    context 'when it has valid parameters' do
      before(:each) do
        @sport_attributes =  FactoryBot.attributes_for(:sport)
        post sports_path, params: { sport: @sport_attributes }
      end
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it 'creates the sport with the correct attributes' do
        expect(Sport.last).to have_attributes(@sport_attributes)
      end
    end

    context 'when it has no valid parameters' do
      before(:each) do
        post(sports_path, params: { sport: { name: '', victory_rule: '' } })
      end

      it 'returns http unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not create sport' do
        expect {
          post(sports_path, params: { sport: { name: '', victory_rule: '' } })
        }.to_not change(Sport, :count)
      end
    end
  end

  describe "PUT /sports/:id" do
    context 'when the sport exists' do
      let(:sport) { create(:sport) }
      let(:sport_attributes) { attributes_for(:sport) }

      before(:each) { put "/sports/#{sport.id}", params: {sport: sport_attributes} }
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'updates the record' do
        expect(sport.reload).to have_attributes(sport_attributes)
      end
    end

    context 'when the sport does not exists' do
      it "returns http not found" do
        put '/sports/0', params: attributes_for(:sport)
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "DELETE /sports" do
    context 'when the sport exists' do
      let(:sport) { create(:sport) }
      before(:each) { delete "/sports/#{sport.id}" }
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
      it 'destroys the record' do
        expect { sport.reload }.to raise_error ActiveRecord::RecordNotFound
      end
    end
    context 'when the sport does not exists' do
      before(:each) { delete '/sports/0' }
      it 'returns http not_found' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
