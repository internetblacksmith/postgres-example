# frozen_string_literal: true

class Album < ActiveRecord::Base
  belongs_to :artist
  has_many :songs

  def formatted_release_date
    release_date.strftime("%b %d %Y")
  end
end
