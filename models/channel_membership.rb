# frozen_string_literal: true

class ChannelMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel
end
