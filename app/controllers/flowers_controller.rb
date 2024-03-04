class FlowersController < ApplicationController
  def index
    @flowers = Flower.all

    @flowers = @flowers.where(color: params[:color]) if params[:color].present?

    @flowers = @flowers.where("name LIKE ?", "%#{params[:search]}%") if params[:search].present?

    @flowers = @flowers.where("description LIKE ?", "%#{params[:description_search]}%") if params[:description_search].present?

    if params[:min_price].present? || params[:max_price].present?
      min_price = params[:min_price].presence || 0
      max_price = params[:max_price].presence || 2**31 - 1
      @flowers = @flowers.where(price: min_price.to_i..max_price.to_i)
    end
    
    @flowers = @flowers.where("equipment LIKE ?", "%#{params[:equipment].join('%')}%") if params[:equipment].present?
    @flowers = @flowers.where(sale: params[:sale]) unless params[:sale].nil?

    if params[:vendor] && params[:vendor] != 'Все'
      @flowers = @flowers.where(vendor: params[:vendor])
    end

    if params[:sort] == 'По возрастанию'
      @flowers = @flowers.order(rating: :asc)
    elsif params[:sort] == 'По убыванию'
      @flowers = @flowers.order(rating: :desc)
    end
    
    if params[:sort_popular] == 'По возрастанию'
      @flowers = @flowers.order(purchased_count: :asc)
    elsif params[:sort_popular] == 'По убыванию'
      @flowers = @flowers.order(purchased_count: :desc)
    end
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
