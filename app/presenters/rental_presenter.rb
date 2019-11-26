class RentalPresenter < SimpleDelegator
  # attr_reader :rental

  delegate :content_tag, to: :helper

  # def initialize(rental)
  #   # @rental = rental
  #   super(rental)
  # end

  def status_badge
    # helper.content_tag :span, class: "badge badge-#{rental.status}" do
    helper.content_tag :span, class: "badge badge-#{status}" do
      # I18n.t(rental.status)
      I18n.t(status)
    end
  end

  private

  #classe cache p/ usar todo o ApplicationController e o que ele possui
  def helper
    @helper ||= ApplicationController.helpers
  end
end

# Usando o SimpleDelegator e o super a classe responde como se fosse o objeto em si (no caso, o rental)