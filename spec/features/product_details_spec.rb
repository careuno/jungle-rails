require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
    # SETUP
    before :each do
      @category = Category.create! name: 'Apparel'
  
      10.times do |n|
        @category.products.create!(
          name:  Faker::Hipster.sentence(3),
          description: Faker::Hipster.paragraph(4),
          image: open_asset('apparel1.jpg'),
          quantity: 10,
          price: 64.99
        )
      end
    end

    scenario "They see product details" do
      # ACT
      visit root_path
      #el.click 'article.product'
      #first(".product").click #expected to find css "product-details" but there were no matches
      #first("img").click #expected to find css "product-details" but there were no matches
      first(".product-name").click

      find(".products-show") #find is needed, cause the code will continue to look for it .product-show before going to next line of code, without it, it will screenshot before redirect
      save_screenshot
      
      #puts product
      puts page.html
      
      # DEBUG / VERIFY
      #save_screenshot
      #Since each _product partial renders an article with class product, we are expecting to find at least one on the page.
      expect(page).to have_css '.product-detail'
    end
    
  end
  
