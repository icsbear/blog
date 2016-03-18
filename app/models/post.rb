class Post < ActiveRecord::Base
	validates :title, presence: true, length: { minimum: 5 }
	validates :body, presence:true
	acts_as_taggable
	scope :by_join_date, -> { order("created_at DESC") }
	# acts_as_taggable_on :life, :rails, :frontend

end
