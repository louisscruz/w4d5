# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :text
#  content    :text
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates :title, :user_id, presence: true
  validate :has_a_sub

  belongs_to :author,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :post_subs,
    primary_key: :id,
    foreign_key: :post_id,
    class_name: :PostSub,
    inverse_of: :post

  has_many :subs,
    through: :post_subs,
    source: :sub

  def has_a_sub
    if self.subs.empty?
      self.errors[:post] << "must be associated with a sub"
    end
  end
end
