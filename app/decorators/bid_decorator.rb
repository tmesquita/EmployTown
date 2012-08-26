class BidDecorator < Draper::Base
  decorates :bid
  include Draper::LazyHelpers
  denies :salary_term

  def accept_button(extra_classes = nil)
    unless model.accepted?
      content_tag :span, class: "action-button #{extra_classes}" do
        link_to job_seekers_bid_accept_path(model), class: 'button green' do
          content_tag(:i, '', class: 'icon-ok-sign icon-white') +
          ' Accept'
        end
      end
    end
  end

  def decline_button(extra_classes = nil)
    unless model.declined?
      content_tag :span, class: "action-button #{extra_classes}" do
        link_to job_seekers_bid_decline_path(model), class: 'button red' do
          content_tag(:i, '', class: 'icon-remove-sign icon-white') +
          ' Decline'
        end
      end
    end
  end

  def salary 
    "#{number_to_currency(model.salary)} / #{model.salary_term}"
  end
end
