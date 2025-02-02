# frozen_string_literal: true

require "liquid"
require "jekyll"

module ExtraTextFilters
  def regex_remove_first(input, regex)
    input.to_s.sub(Regexp.new(regex), "")
  end

  def regex_remove(input, regex)
    input.to_s.gsub(Regexp.new(regex), "")
  end

  def regex_replace_first(input, regex, replacement = "")
    input.to_s.sub(Regexp.new(regex.to_s), replacement.to_s)
  end

  def regex_replace(input, regex, replacement = "")
    input.to_s.gsub(Regexp.new(regex.to_s), replacement.to_s)
  end

  def regex_matching(input, regex)
    return false if regex.nil? || regex.to_s.empty?
    input.to_s.match?(Regexp.new(regex.to_s))
  end

  def strip_site_url(input)
    url = input.to_s
    site_url = @context.registers[:site].config["url"]
    if site_url
      site_url = site_url.sub(%r{^https?://}, "").sub(%r{/$}, "")
      url.sub!(%r{^https?://#{Regexp.escape(site_url)}/}, "/")
    end
    url
  end
end

Liquid::Template.register_filter(ExtraTextFilters)
