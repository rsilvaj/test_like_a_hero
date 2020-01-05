require 'rails_helper'

RSpec.describe Enemy, type: :model do
  let(:enemy) { build(:enemy) }
  after(:each) { expect(enemy).to_not be_valid }

  it "given level is not between 1 and 99" do 
    enemy.level = FFaker::Random.rand(100..9999)
  end  
  
  it "given name is not present" do 
    enemy.name = ''
  end  
  
  it "given power base is not present" do 
    enemy.power_base = ''
  end  
  
  it "given power step is not present" do
    enemy.power_step = ''
  end  
  
  it "given level is not present" do 
    enemy.level = ''
  end  
  
  it "given kind is not present" do 
    enemy.kind = ''
  end  

end