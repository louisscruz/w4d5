# == Schema Information
#
# Table name: post_subs
#
#  id         :integer          not null, primary key
#  sub_id     :integer          not null
#  post_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
