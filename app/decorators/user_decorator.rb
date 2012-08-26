class UserDecorator < Draper::Base
  decorates :user
  include Draper::LazyHelpers
  denies :blog_address, :about_me

  def facebook
    link_to image_tag('facebook-logo-small.png', class: 'social'), "http://www.facebook.com/#{model.facebook}", target: '_blank' if model.facebook.present?
  end

  def twitter
    link_to image_tag('twitter-bird-dark-bgs-small.png', class: 'social'), "http://www.twitter.com/#{model.twitter}", target: '_blank' if model.twitter.present?
  end

  def blog
    link_to image_tag('blog-icon-black-20.png', class: 'social'), url_with_protocol(model.blog_address), target: '_blank'
  end

  def phone
    number_to_phone model.contact_phone, area_code: true
  end

  def resume
    if model.has_resume?
      link_to 'View my resume', model.resume.url
    else
      'No resume uploaded'
    end
  end

  def ideal_role
    simple_format(truncate(model.ideal_role, length: 200)) +
    if model.ideal_role.length > 200
      link_to 'Read more', user_path(model), class: 'small-link'
    end
  end

  def about
    simple_format(truncate(model.about_me, length: 200)) +
    if model.about_me.length > 200
      link_to 'Read more', user_path(model), class: 'small-link'
    end
  end

  def send_bid_button(extra_classes = nil)
    if current_user.company.nil?
      content_tag :span, class: "action-button disabled bootstrapTooltip #{extra_classes}", rel: 'tooltip', 'data-title' => "Add your company to bid on #{user}", 'data-delay' => 800 do
        link_to 'Send a bid', '#', class: 'button', style: 'cursor: not-allowed'
      end
    else
      if model.has_bid_from_employer? current_user
        content_tag :span, 'Bid already sent!', class: "action-button #{extra_classes}" if extra_classes
      else
        content_tag :span, class: "action-button #{extra_classes}" do
          link_to new_employers_job_seeker_bid_path(user.id), class: 'button' do
            content_tag(:i, '', class: 'icon-envelope icon-white') +
            ' Send a Bid'
          end
        end
      end
    end
  end

  def to_s
    model.to_s
  end

end
