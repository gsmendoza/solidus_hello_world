# frozen_string_literal: true

Spree::Core::Engine.routes.draw do
  if SolidusSupport.frontend_available?
    resources :pages, only: :show
  end
end
