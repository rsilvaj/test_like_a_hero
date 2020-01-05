class Enemy < ApplicationRecord
  enum kind: [ :globin, :orc, :demon, :dragon ]
  validates :level, numericality: { greater_than:0 , less_than_or_equal_to: 99 }
  validates_presence_of :name, :power_base, :power_step, :level, :kind

  def as_json(options={})
    super.as_json(options).merge({
      current_power: current_power
    })
  end  

  def current_power
    power_base + ((level - 1) * power_step)
  end
end
