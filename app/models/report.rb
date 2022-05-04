class Report < ActiveRecord::Base
  belongs_to :user, class_name: "User" 
  validates :title, presence: true
end
