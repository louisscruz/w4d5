class PostSub < ActiveRecord::Base
  validates :post, :sub, presence: true
  validates :sub_id, uniqueness: { scope: :post_id, message: "no duplicates" }

  belongs_to :post,
    primary_key: :id,
    foreign_key: :post_id,
    class_name: :Post
  belongs_to :sub,
    primary_key: :id,
    foreign_key: :sub_id,
    class_name: :Sub
end
