class SubCategory < ActiveRecord::Base
  belongs_to :category
  has_many :posts, dependent: :destroy

  validates :name, presence: true
  validates :category_id, presence: true

  after_save :update_cache_time

  def update_cache_time
    ss = SystemSetting.find_by_name("cache")
    ss.value['sub_category'] = Time.now.utc.to_s.gsub!(/[ : +-]+/,'_')
    ss.update_attribute(:value, ss.value)
  end
end
