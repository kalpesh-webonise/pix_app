class Category < ActiveRecord::Base
  has_many :sub_categories, dependent: :destroy
  belongs_to :posts, dependent: :destroy

  validates :name, presence: true

  after_save :update_cache_time

  def update_cache_time
    ss = SystemSetting.find_by_name("cache")
    ss.value['category'] = Time.now.utc.to_s.gsub!(/[ : +-]+/,'_')
    ss.update_attribute(:value, ss.value)
  end
end
