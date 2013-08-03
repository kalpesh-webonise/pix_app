class Post < ActiveRecord::Base
  belongs_to :user, foreign_key: "user_id"
  has_many :comments, dependent: :destroy


  validates :title, presence: true
  validates :description, presence: true
  validates :category_id, presence: true
  validates :sub_category_id, presence: true
  validates :location, presence: true
  validates :price, presence: true
  validates :name, presence: true
  validates :contact_number, presence: true
  validates_numericality_of :price, :contact_number

  def self.fetch_posts params, user
    posts = select("id, title, location")
    if user.favourite_post_ids.empty?
      posts = posts.order("updated_at DESC")
    else
      posts = posts.order("FIELD(id #{user.favourite_post_ids.join(",")})")
    end
    posts = posts.where("category_id=?", params[:category_id]) if params[:category_id].present?
    posts = posts.where("sub_category_id=?", params[:sub_category_id]) if params[:sub_category_id].present?
    if params[:post_type].present?
      if params[:post_type] == "favourite"
        posts = posts.where("id IN (?)", user.favourite_post_ids)
      else
        posts = posts.where("user_id = ?", user.id)
      end
    end
    self.per_page = 10
    #posts = posts.page(params[:page]).per(10)
    posts
  end
end
