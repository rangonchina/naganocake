class Admin::ItemsController < ApplicationController
    
    def new
     @item = Item.new
    end
    
    def index
     @item = Item.new
     @items = Item.all
    end
    
    def show
     @item = Item.find(params[:id])
    end
    
    def edit
     @item = Item.find(params[:id])
    end
     
    def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path(@item)
    else
      flash[:genre_created_error] = "ジャンル名を入力してください"
    redirect_to new_admin_items_path
    end
    end
    
    def update
       @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_items_path(@item)
      flash[:notice_update] = "ジャンル情報を更新しました！"
    else
      redirect_to edit_admin_item_path(@item)
    end
    end
    
    
    
    private
     # ストロングパラメータ
  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :image, :is_active)
  end
    
end
