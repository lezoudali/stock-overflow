# == Schema Information
#
# Table name: forum_threads
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  subject    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#  content    :text
#
# Indexes
#
#  index_forum_threads_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe ForumThread, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
