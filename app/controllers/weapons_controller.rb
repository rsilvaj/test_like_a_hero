class WeaponsController < ApplicationController

  def index
    @weapons = Weapon.all 
  end

  def create
    weapon = Weapon.create(weapon_params)
    redirect_to weapons_path
  end  

  def show
    @weapon = Weapon.find(params[:id])
  end

  def destroy
    id     = params[:id]
    weapon = Weapon.find(id)
    weapon.destroy
    flash[:notice] = "Weapon ##{id} was deleted"
    redirect_to weapons_path
  end  

  private

  def weapon_params
    params.require(:weapon).permit(:name, :description, :level, :power_base, :power_step)
  end  

end  