# Top-level class for communicating well designed consumer-facing pages.
class PagesController < ApplicationController
  def self.privacy_md
    @privacy_md ||= File.read(Rails.root / "PRIVACY.md")
  end

  def privacy
    pipeline = HTML::Pipeline.new [
      HTML::Pipeline::MarkdownFilter
    ], gfm: true, asset_root: "/images"
    @page_body = pipeline.call(privacy_md)[:output].to_s
  end

  def support
    redirect_to "mailto:atmos+epicmix+support@atmos.org"
  end

  def home; end

  private

  def privacy_md
    self.class.privacy_md
  end
end
