require 'rails_helper'

RSpec.describe Weapon, type: :model do
  it "returns current weapon power" do 
    weapon = build(:weapon)
    current_power = weapon.power_base + ((weapon.level - 1) * weapon.power_step)
    expect(weapon.current_power).to eq(current_power)
  end  
  it "returns weapon title" do
    name = FFaker::Name.name
    level = FFaker::Random.rand(1..99)
    weapon = build(:weapon, name: name, level: level)
    expect(weapon.title).to eq("#{name} ##{level}")
  end  
end
