class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  include ActiveModel::ForbiddenAttributesProtection

  serialize :favourite_post_ids, Array
  attr_accessor :tmp_password

  after_create :welcome_email
 # Setup accessible (or protected) attributes for your model

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :first_name, :last_name, presence: true

  def mark_unmark_favourite(params)
    response = ''
    if params['fav'] == 'true'
      self.favourite_post_ids << params[:post_id].to_i
      self.favourite_post_ids.uniq!
      response = 'favOn'
    else
      self.favourite_post_ids.delete(params[:post_id].to_i)
      response = 'favOff'
    end
    self.save
    response
  end

  private
  def welcome_email
    UserMailer.delay.welcome_email(self, self.tmp_password)
  end

end
