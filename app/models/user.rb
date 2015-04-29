# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string
#  last_name              :string
#  image                  :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string
#  uid                    :string
#  deleted_at             :datetime
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  acts_as_paranoid

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, :omniauth_providers => [:facebook]

  has_many :messages
  has_many :user_stocks
  has_many :favorites
  has_many :favorite_stocks, through: :favorites, source: :stock
  has_many :stocks, through: :user_stocks
  has_many :forum_threads, dependent: :destroy
  has_many :forum_posts, dependent: :destroy

  def name
    deleted_at? ? "Deleted User" : "#{first_name} #{last_name}"
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def get_stocks_tweets
    tweets = []
    self.stocks.first(5).each do |stock|
      tweets << stock.tweets
    end
    tweets.flatten
  end

  def get_stocks_articles
    articles = []
    self.stocks.first(5).each do |stock|
      articles << stock.find_articles
    end
    articles.flatten
  end

  def stocks_without_favorites
    stocks - favorite_stocks
  end

  def favorite_tweets
    fav = self.favorite_stocks
    favorite_stocks.map do |stock|
      if fav.count == 1
        stock.tweets.take(10)
      elsif fav.count == 2
        # binding.pry
        stock.tweets.take(5)
      elsif fav.count == 3
        stock.tweets.take(4)
      elsif fav.count == 4
        stock.tweets.take(3)
      elsif fav.count == 5
        stock.tweets.take(2)
      end
    end
  end

  def favorite_articles
    fav = self.favorite_stocks
    favorite_stocks.map do |stock|
      if fav.count == 1
        stock.find_articles.take(10)
      elsif fav.count == 2
        stock.find_articles.take(5)
      elsif fav.count == 3
        stock.find_articles.take(4)
      elsif fav.count == 4
        stock.find_articles.take(3)
      elsif fav.count == 5
        stock.find_articles.take(2)
      end
    end
  end

  def following?
    self.stocks.present?
  end

end
