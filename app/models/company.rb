class Company < ActiveRecord::Base
    has_many :stores, foreign_key: "company_id" 
end