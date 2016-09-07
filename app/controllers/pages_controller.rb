class PagesController < ApplicationController
  include HighVoltage::StaticPage

  layout :layout_for_page

  private

  def layout_for_page
    case params[:id]
      when 'about_me'
        'about_me'
      else
        'application'
    end
  end
end
