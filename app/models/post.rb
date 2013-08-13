class Post < ActiveRecord::Base
  belongs_to :user, foreign_key: "user_id"
  has_many :comments, dependent: :destroy
  has_many :photos, :dependent => :destroy
  accepts_nested_attributes_for :photos
  validates :title, :description, :category_id, :sub_category_id, :location, :price, :name, :contact_number, presence: true
  validates_numericality_of :price, :contact_number

  def self.fetch_posts params, user
    posts = select("id, title, location, user_id").order("updated_at DESC")
    posts = posts.where("category_id=?", params[:category_id]) if params[:category_id].present?
    posts = posts.where("sub_category_id=?", params[:sub_category_id]) if params[:sub_category_id].present?
    if params[:post_type] == "favourite"
      posts = posts.where("id IN (?)", user.favourite_post_ids)
    elsif params[:post_type] == "my_ads"
      posts = posts.where("user_id = ?", user.id)
    end
    posts = posts.page(params[:page]).per(10)
    posts
  end
end
