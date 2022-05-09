class Slvcdata < ActiveRecord::Base
    has_many :stores, foreign_key: "zip", primary_key: "zip"
end