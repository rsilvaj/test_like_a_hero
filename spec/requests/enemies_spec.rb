require 'rails_helper'

RSpec.describe "Enemies", type: :request do

  describe "GET /enemies" do
    let(:enemies) { create_list(:enemy, 10) }
    before(:each) { enemies }
    before(:each) { get enemies_path }

    it 'returns success status' do
      get enemies_path
      expect(response).to have_http_status(200)
    end
    it 'the enemies\'s name is present ' do
      enemies.each do |enemy|          
        expect(json.to_s).to match(enemy.name)
      end  
    end  
    it 'the enemies\'s power_base is present' do
      enemies.each do |enemy|          
        expect(json.to_s).to match("#{enemy.power_base}")
      end  
    end
    it 'the enemies\'s level is present' do
      enemies.each do |enemy|          
        expect(json.to_s).to match("#{enemy.level}")
      end  
    end        
    it 'the enemies\'s kind is present' do
      enemies.each do |enemy|          
        expect(json.to_s).to match(enemy.kind)
      end  
    end
    it 'the enemies\'s current_power is present' do
      enemies.each do |enemy|          
        expect(json.to_s).to match("#{enemy.current_power}")
      end  
    end
  end
  

  describe "GET /enemies/:id" do
    it "the weapon fields are present" do
      enemy = create(:enemy)
      get enemy_path(enemy.id)
      expect(json.to_s).to match(enemy.name)
      expect(json.to_s).to match("#{enemy.power_base}")
      expect(json.to_s).to match("#{enemy.level}")
      expect(json.to_s).to match(enemy.kind)
      expect(json.to_s).to match("#{enemy.current_power}")
    end  
  end
  
  describe "POST /enemies" do
    context "when it has valid parameters" do
      it "creates the enemy with correct attributes" do 
        enemy_attributes = FactoryBot.attributes_for(:enemy)
        post enemies_path, params: enemy_attributes
        expect(Enemy.last).to have_attributes(enemy_attributes)
      end
    end

    context "when it has no valid parameters" do
      it "does not create enemy" do 
        expect{
          post enemies_path, params: { name: '', power_base: '', level: '', kind: '' }
      }.to_not change(Enemy, :count)
      end  
    end  
  end  

  describe "PUT /enemies" do
    context 'when the enemy exists' do 
      let(:enemy) { create(:enemy) }
      let(:enemy_atrributes) { attributes_for(:enemy) }
  
      before(:each) {put "/enemies/#{enemy.id}", params: enemy_atrributes }

      it 'returns status code 200' do 
        expect(response).to have_http_status(200)
      end  
      it 'updates the record' do
        expect(enemy.reload).to have_attributes(enemy_atrributes)
      end
      it 'returns the enemy updated' do 
        expect(enemy.reload).to have_attributes(json.except('created_at', 'updated_at'))
      end  
    end
    
    context 'when the enemy does not exists' do
      before(:each) { put '/enemies/0', params: attributes_for(:enemy) }
      it 'returns status code 404' do 
        expect(response).to have_http_status(404)
      end  
      it 'returns a not found message' do 
        expect(response.body).to match(/Couldn't find Enemy/)
      end  
    end
  end

  describe "DELETE /enemies" do
    context 'when the enemy exists' do
      let(:enemy) { create(:enemy) }
      before(:each) { delete "/enemies/#{enemy.id}" }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end  
      it 'destroy the record' do
        expect { enemy.reload }.to raise_error ActiveRecord::RecordNotFound  
      end  
    end  

    context 'when the enemy does not exist' do
      before(:each) { delete "/enemies/0" }
      it 'returns status code 404' do 
        expect(response).to have_http_status(404)
      end  
      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end  
  end

end
