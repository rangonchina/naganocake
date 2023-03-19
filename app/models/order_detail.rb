class OrderDetail < ApplicationRecord
     enum production_status: { start_not_possible: 0, production_pending: 1, in_production: 2, production_complete: 3 }
    belongs_to :order
    belongs_to :item
end
