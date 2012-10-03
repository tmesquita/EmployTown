class CompanyDecorator < Draper::Base
  decorates :company
  include Draper::LazyHelpers
  denies :company_url, :blog_address

  def facebook
    link_to image_tag('facebook-logo-small.png', class: 'social'), "http://www.facebook.com/#{model.facebook}", target: '_blank' if model.facebook.present?
  end

  def twitter
    link_to image_tag('twitter-bird-dark-bgs-small.png', class: 'social'), "http://www.twitter.com/#{model.twitter}", target: '_blank' if model.twitter.present?
  end

  def blog
    link_to image_tag('blog-icon-black-20.png', class: 'social'), url_with_protocol(model.blog_address), target: '_blank' if model.blog_address.present?
  end

  def logo(size = :regular)
    if model.logo_file_name
      image_tag model.logo.url(size)
    else
      image_tag 'default_profile.jpg'
    end
  end

  def website
    unless model.company_url.blank?
      content_tag :div, class: 'website' do
        content_tag(:span, 'Company Website', class: 'title') +
        raw(": #{link_to(model.company_url, url_with_protocol(model.company_url), target: '_blank')}")
      end
    end
  end

  def to_s
    model.to_s
  end
  
end
