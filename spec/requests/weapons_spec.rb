require 'rails_helper'

RSpec.describe "Weapons", type: :request do
  describe "GET /weapons" do
    let(:weapons) { create_list(:weapon, 10) }
    before(:each) { weapons }
    before(:each) { get weapons_path }

    it "the weapon name is present" do
      weapons.each do |weapon|
        expect(response.body).to include(weapon.name)
      end   
    end  
    it "the current_power is present" do
      weapons.each do |weapon|
        expect(response.body).to include("#{weapon.current_power}")
      end 
    end  
    it "the title is present" do
      weapons.each do |weapon|
        expect(response.body).to include(weapon.title)
      end  
    end  
    it "the links are present" do
      weapons.each do |weapon|
        expect(response.body).to include("/weapons/#{weapon.id}")
      end
    end  
  end

  describe "/GET weapon/:id" do
    it "the weapon fields are present" do
      weapon = create(:weapon)
      get weapon_path(weapon.id)
      expect(response.body).to include(weapon.name)
      expect(response.body).to include(weapon.description)
      expect(response.body).to include("#{weapon.level}")
      expect(response.body).to include("#{weapon.power_base}")
      expect(response.body).to include("#{weapon.power_step}")
      expect(response.body).to include("#{weapon.current_power}")
      expect(response.body).to include(weapon.title)
    end  
  end  

  describe "/POST weapons" do
    context "when the parameters are correct" do 
      it "create weapon" do
        weapon_attributes = FactoryBot.attributes_for(:weapon)
        post weapons_path, params: { weapon: weapon_attributes }
        expect(Weapon.last).to have_attributes(weapon_attributes)
      end  
    end
    context "when the parameters are incorrect" do
      it "does not create weapon" do
        expect {
          post weapons_path, params: { weapon: { name: '', description: '', level: '', power_base: '', power_step: ''  }}
        }.to_not change(Weapon, :count)
      end  
    end    
  end  

  describe "/DELETE weapon/:id" do
    it "if correct weapon is destroyed" do
      weapon = create(:weapon)
      delete weapon_path(weapon.id)
      expect(flash[:notice]).to include("#{weapon.id}")
    end  
  end  
end
