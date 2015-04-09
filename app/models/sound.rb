class Sound < ActiveRecord::Base
  validates :title, uniqueness: { case_sensitive: false }
end
