# frozen_string_literal: true

class Song < ActiveRecord::Base
  belongs_to :album
end
