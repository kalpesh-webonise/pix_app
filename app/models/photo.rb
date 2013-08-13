class Photo < ActiveRecord::Base
  belongs_to :posts
  mount_uploader :image, AvatarUploader
end
