class Weapon < ApplicationRecord

  validates :name, :description, :power_base, :level, :power_step, presence: true

  def current_power
    power_base + ((level - 1) * power_step)
  end  

  def title
    "#{name} ##{level}"
  end  

end
