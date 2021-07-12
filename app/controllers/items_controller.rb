class ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
    @item_tags = @item.tags
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    tag_list = params[:item][:tag_name].split(",")
    if @item.save
      @item.save_tag(tag_list)
      redirect_to item_path(@item), notice: 'Itemを作成しました。'
    else
      flash.now[:danger] = '作成に失敗しました。'
      render 'new'
    end
  end

  def edit
    @item = Item.find(params[:id])
    @item_tags = @item.tags
  end

  def update
    @item = Item.find(params[:id])
    @item_tags = @item.tags
    tag_list = params[:item][:tag_name].split(nil)
    if @item.update
      @item.save_tag(tag_list)
      redirect_ot item_path(@item), notice: 'Itemを作成しました。'
    else
      @item = Item.find(params[:id])
      @item_tags = @item.tags
      tag_list = params[:item][:tag_name].split(",")
      flash.now[:danger] = '作成に失敗しました。'
      render 'edit'
    end
  end

  private
    def item_params
     params.require(:item).permit(:name, :image_id, :description)
    end
end
