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

  def cancel_button(extra_classes = nil)
    content_tag :span, class: "action-button #{extra_classes}" do
      link_to employers_bid_path(bid), :data => { :confirm => 'Are you sure you want to cancel this bid? This cannot be undone' }, method: :delete, class: 'button red cancel' do
        content_tag(:i, '', class: 'icon-trash icon-white') +
        'Cancel Bid'
      end
    end
  end

  def company_website
    if model.employer.company.company_url.present?
      link_to model.employer, url_with_protocol(model.employer.company.company_url), target: '_blank'
    else
      model.employer
    end
  end

  def status
    return content_tag :div, '', class: 'bulb accepted bootstrapTooltip', rel: 'tooltip', 'data-title' => 'Bid has been accepted' if model.accepted?
    return content_tag :div, '', class: 'bulb declined bootstrapTooltip', rel: 'tooltip', 'data-title' => 'Bid has been declined' if model.declined?
    return content_tag :div, '', class: 'bulb not-responded bootstrapTooltip', rel: 'tooltip', 'data-title' => 'Bid is waiting on a response' if model.not_responded?
  end

  def salary 
    "#{number_to_currency(model.salary)} / #{model.salary_term}"
  end
end
