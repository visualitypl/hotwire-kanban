# frozen_string_literal: true

module Cards
  class UpdateCardService
    attr_reader :card

    def initialize(card:, params:)
      @card = card
      @params = params
    end

    def call
      ActiveRecord::Base.transaction do
        card.update!(params)
      end
      true
    rescue ActiveRecord::RecordInvalid
      false
    end

    private

    attr_reader :params
  end
end
