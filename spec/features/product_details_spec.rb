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
  
  
        #product = page.first('article.product').find_link('Details').trigger('click')
      #product = page.first('article.product').find_link('Details')
  #page.first.find_link('Details').click # The browser raised a syntax error while trying to evaluate css selector ""
  #page.find_link('Details').first.trigger('click') #Ambiguous match, found 10 elements matching visible link "Details"
  #first('Details').trigger('click') #expected to find css "Details" at least 1 time but there were no matches
 
  #Capybara.match = first #  The browser raised a syntax error while trying to evaluate css selector ""   
  #find_link("Details").trigger("click") # Ambiguous match, found 10 elements matching visible link "Details"

