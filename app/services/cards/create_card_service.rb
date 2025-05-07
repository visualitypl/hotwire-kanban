# frozen_string_literal: true

module Cards
  class CreateCardService
    attr_reader :card

    def initialize(params:)
      @params = params
    end

    def call
      @card = Card.new(params)

      ActiveRecord::Base.transaction do
        card.save!
      end
      true
    rescue ActiveRecord::RecordInvalid
      false
    end

    private

    attr_reader :params
  end
end
