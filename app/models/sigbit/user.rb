module Sigbit
  class User < Sigbit::ApplicationRecord
    rolify role_cname: "Sigbit::Role"
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable

    after_create :add_admin_roles

    devise :database_authenticatable,
           :recoverable, :rememberable, :trackable, :validatable

    has_attachment :image

    def add_admin_roles
      add_role :admin
    end
  end
end
