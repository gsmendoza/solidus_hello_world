# frozen_string_literal: true

Spree::Core::Engine.routes.draw do
  resources :pages, only: :show
end
