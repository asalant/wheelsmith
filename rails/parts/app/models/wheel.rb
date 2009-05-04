class Wheel < ActiveRecord::Base
  belongs_to :hub
  belongs_to :rim
end
