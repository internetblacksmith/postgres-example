# frozen_string_literal: true

class Artist < ActiveRecord::Base
  has_many :albums
end
