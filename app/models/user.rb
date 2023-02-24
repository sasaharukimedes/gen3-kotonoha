class User < ApplicationRecord
  class << self
    def find_or_create_from_auth_hash(auth_hash)
      user_params = user_params_from_auth_hash(auth_hash)
      find_or_create_by(email: user_params[:email]) do |user|
        user.update(user_params)
      end
    end

    attribute :received_at, :datetime, default: -> { Time.now }

    has_many :posts, dependent: :destroy

    validates :name, presence: true
    validates :birthday, presence: true
    validates :received_at, presence: true


    #アクティブで自分からの通知パッシブは他人から
    has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
    has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

        private

        def user_params_from_auth_hash(auth_hash)
          {
            name: auth_hash.info.name,
            email: auth_hash.info.email,
            birthday: auth_hash.info.birthday,
            received_at: auth_hash.info.received_at
          }
        end
  end

end
