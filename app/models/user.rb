class User < ApplicationRecord
  class << self
    def find_or_create_from_auth_hash(auth_hash , status)
      user_params = user_params_from_auth_hash(auth_hash)
      find_or_initialize_by(email: user_params[:email]) do |user|
        user.transaction do
          user.status = 'needs_birthday'
          user.update!(user_params)
        end
      end
    end

    private

    def user_params_from_auth_hash(auth_hash)
      {
        email: auth_hash.info.email,
        }
    end
  end

    attribute :received_at, :datetime, default: -> { Time.current }
    has_many :posts, dependent: :destroy
    has_one :profile, dependent: :destroy

    validates :name, presence: true, if: -> { status == 'registered' }
    validates :email, presence: true, uniqueness: true
    validates :birthday, presence: true, if: -> { status == 'registered' }
    validates :received_at, presence: true


    #アクティブで自分からの通知パッシブは他人から
    has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
    has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy


end
