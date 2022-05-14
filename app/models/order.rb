class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { wait_payment: 0, payment_confirmation: 1, under_construction: 2, in_preparation: 3, already_sent: 4}
  belongs_to :customer
  has_many :order_items
end
