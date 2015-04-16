class User < ActiveRecord::Base
  belongs_to :list
  belongs_to :inventory
end
