class Public::CartItemsController < ApplicationController
    
    def index
        @cart_items = current_customer.cart_items
        #@total_price = @cart_items.sum(@cart_items.with_tax_price * @cart_items.quantity * 1.1)
    end

    # カート商品を追加する
    def create
        # @cart_item = current_customer.cart_items.build(item_id: params[:item_id])
        @cart_item = CartItem.new(cart_item_params)
        @cart_item.customer_id = current_customer.id
        @cart_item.item_id = params[:cart_item][:item_id]
        @in_cart = CartItem.find_by(item_id: params[:cart_item][:item_id],customer_id: current_customer.id)
        # byebug
        if @in_cart 
           @cul_quantity = @in_cart.quantity.to_i + params[:cart_item][:quantity].to_i
           @in_cart.update(quantity: @cul_quantity)
           redirect_to cart_items_path
        else
        if @cart_item.save!
           redirect_to    cart_items_path
        else
            @item = Item.find(params[:cart_item][:item_id])
            @genres = Genre.all
            render "public/items/show"
        end  
        end    
        
    end

    # 削除や個数を変更した際、カート商品を再計算する
    def update
        @cart_item = CartItem.find(params[:id])
        #@cart.units += cart_params[:units].to_i
        @cart_item.update(cart_item_params)
        redirect_to cart_items_path
    end

    # カート商品を一つのみ削除
    def destroy
        @cart_item = CartItem.find(params[:id])
        @cart_item.destroy
        flash.now[:alert] = "#{@cart_item.item.name}を削除しました"
        redirect_to cart_items_path
    end

    # カート商品を空ににする
    def all_destroy
        @cart_item = current_customer.cart_items
        @cart_item.destroy_all
        flash[:alert] = "カートの商品を全て削除しました"
        redirect_to cart_items_path
    end

    private

      def cart_item_params
        params.require(:cart_item).permit(:quantity, :item_id, :customer_id)
      end

end
