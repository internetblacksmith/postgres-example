# frozen_string_literal: true

class Config < ActiveRecord::Base
  def self.current_status
    find_by(key: "current_status").value
  end
end
