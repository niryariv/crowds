class Ownership < ActiveRecord::Base
  
  belongs_to :feed
  belongs_to :crowd
  
end
