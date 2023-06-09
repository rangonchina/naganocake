class Admin::OrdersController < ApplicationController
    
    before_action :authenticate_admin!

	def show
		@order = Order.find(params[:id])
		@order_details = @order.order_details
		@customer = @order.customer
		@sum = 0
	end

	def total(items_total_price)

	end

    def create
        @cart_item.item_id = params[:cart_item][:item_id]

        if @order.save!
           redirect_to  admin_order_path
        else
            render "admin/orders/show"
        end
    end

	def update
		order = Order.find(params[:id])
		order_details = order.order_details
        order.update(order_params)

		if order.order_status == "入金確認"
		end
		redirect_to admin_order_path(order.id)
	end

  private
	def order_params
		params.require(:order).permit(:order_status)
	end

    
end
