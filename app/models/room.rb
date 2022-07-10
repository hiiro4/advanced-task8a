class Room < ApplicationRecord
  has_many:entrys,dependent: :destroy
  has_many:messages,dependent: :destroy
end
