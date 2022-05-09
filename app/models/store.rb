class Store < ActiveRecord::Base
    belongs_to :company, foreign_key: "company_id"
    has_one :slvcdata, foreign_key: "zip", primary_key: "zip"
end