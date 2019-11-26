module ApplicationHelper
  def rental_helpers(rental)
    content_tag :span, class: "badge badge-#{rental.status}" do
      t(rental.status)
    end
  end
end
