require 'spec_helper'

RSpec.describe "Pages", type: :feature do
  describe 'hello world page' do
    it 'displays Hello World' do
      visit spree.page_path 'hello_world'
      expect(page).to have_content('Hello World')
    end

    it 'displays Hello World JS content', :js do
      visit spree.page_path 'hello_world'
      expect(page).to have_content('Hello World from JS!')
    end
  end
end
