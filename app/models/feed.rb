class Feed < ActiveRecord::Base
  has_many :fetches, dependent: :destroy
end
