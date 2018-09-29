module Sigbit
  class User < Sigbit::ApplicationRecord
    rolify role_cname: "Sigbit::Role"
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable,
           :recoverable, :rememberable, :trackable, :validatable

    has_attachment :image
  end
end
