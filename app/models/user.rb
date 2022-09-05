class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # TODO : ハッシュデータをモデルとして定義(都道府県を入力するため)
  extend ActiveHash::Associations::ActiveRecordExtensions

  # TODO : ユーザーにプロフィール画像を持たせるため。
  has_one_attached :icon
  belongs_to :prefecture
  has_many :rules, dependent: :destroy
  has_many :players, dependent: :destroy
  has_many :score_sheets, dependent: :destroy
  accepts_nested_attributes_for :players
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  # フォローをした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  validates :name, presence: true
  validates :email, presence: true
  validates :prefecture_id, presence: true

  # フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

  # TODO : Rails内でプロフィール画像を処理させる。
  def get_icon(width, height)
    unless icon.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      icon.attach(io: File.open(file_path), filename: 'default-icon.png', content_type: 'image/png')
    end
    icon.variant(resize_to_fill: [width, height]).processed
  end

end
