class Stock < ApplicationRecord
    has_many :prices, dependent: :destroy
end
