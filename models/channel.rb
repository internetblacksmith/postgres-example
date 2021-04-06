# frozen_string_literal: true

class Channel < ActiveRecord::Base
  has_many :channel_memberships
  has_many :users, through: :channel_memberships
end
