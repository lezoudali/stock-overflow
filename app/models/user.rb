class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  
  def name
    "#{first_name} #{last_name}"
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
      tweets << stock.find_tweets
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


end
