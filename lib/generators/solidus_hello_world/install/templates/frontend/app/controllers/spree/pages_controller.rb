module Spree
  class PagesController < Spree::StoreController
    def show
      render params[:id]
    rescue ActionView::MissingTemplate => e
      raise ActionController::RoutingError, e
    end
  end
end
