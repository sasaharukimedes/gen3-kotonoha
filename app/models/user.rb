class User < ApplicationRecord
  class << self
    def find_or_create_from_auth_hash(auth_hash)
      user_params = user_params_from_auth_hash(auth_hash)
      find_or_initialize_by(email: user_params[:email]) do |user|
        user.update(user_params, received_at: Time.now, status: 'needs_birthday')
      end
    end
  end

    has_many :posts, dependent: :destroy

    validates :name, presence: true
    validates :birthday, presence: true, if: -> { status: 'registered' }
    validates :received_at, presence: true


    #アクティブで自分からの通知パッシブは他人から
    has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
    has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

        private

        def user_params_from_auth_hash(auth_hash)
          {
            name: auth_hash.info.name,
            email: auth_hash.info.email
          }
        end

end
