# frozen_string_literal: true

module Cards
  class DestroyCardService
    attr_reader :card

    def initialize(card:)
      @card = card
    end

    def call
      ActiveRecord::Base.transaction do
        card.destroy!
      end
      true
    rescue ActiveRecord::RecordInvalid
      false
    end
  end
end
