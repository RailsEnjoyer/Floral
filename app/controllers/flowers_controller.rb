class FlowersController < ApplicationController

  def index
    @flowers = Flower.all
  end

  def show
    @flower = Flower.find(params[:id])
  end

  def new
    @flower = Flower.new
  end

  def create
    @flower = Flower.new(flower_params)
    if @flower.save
      redirect_to @flower, notice: 'Продукт успешно создан'
    else
      render :new
    end
  end

  def edit
    @flower = Flower.find(params[:id])
  end

  def update
    @flower = Flower.find(params[:id])
    if @flower.update(flower_params)
      redirect_to @flower, notice: 'Цветок успешно обновлен'
    else
      render :edit
    end
  end

  def destroy
    @flower = Flower.find(params[:id])
    @flower.destroy
    redirect_to flowers_path, notice: 'Цветок успешно удален'
  end

  private

  def flower_params
    params.require(:flower).permit(:name, :description, :price, :color, :event, :sale, :vendor, :rating, :purchased_count, :image, equipment: [])
  end
end
