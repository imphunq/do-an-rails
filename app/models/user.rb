class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :role
  has_many :wishlists
  has_many :orders
  has_many :notifications

  after_initialize :default_password
  # after_initialize :create_role

  enum gender: {female: 0, male: 1, other: 2}
  enum staff_type: {part_time: 0, full_time: 1}
  mount_uploader :avatar, UserImageUploader

  # validates :name, presence: true, length: {maximum: Settings.max_length_category_name}
  # validates :gender, presence: true, inclusion: {in: genders.keys}
  validates :email, presence: true, format: {with: Devise.email_regexp}
  validates :password, confirmation: true, length: {within: Devise.password_length}, allow_nil: true

  scope :created_desc, ->{order created_at: :desc}

  def enable_status_i18n
    I18n.t("admin.roles.index.is_enable.#{status}")
  end

  def staff_type_i18n
    I18n.t("admin.users.index.staff_types.#{staff_type}")
  end

  def is_admin?
    role.name == Settings.role.admin
  end

  def is_staff?
    role.name == Settings.role.staff
  end

  def is_customer?
    role.name == Settings.role.user
  end

  def default_password
    self.password = "123456" if self.new_record?
  end

  # def create_role
  #   role_group = Role.find_by name: Settings.role.user
  #   self.role_id = role_group.id if role_group
  # end
end
