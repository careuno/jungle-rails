require 'rails_helper'
require 'product'


describe Product, type: :model do
  describe 'Validations' do
    it 'must save with all valid fields' do
      @category = Category.new(name:"Apparel")
      @product = Product.new(name:"Shirt", description:"Fashion axe brooklyn austin bespoke tattooed gastr...", image: "apparel1.jpg", price_cents: 6499, quantity: 10)
      @product.category = @category
      @product.save
      #expect(@product.errors.full_messages).to be_present
      expect(@product.errors.full_messages).to eq([])
      #expect(@product.name).to be_nil
    end
    it 'must have a name' do
      @category = Category.new(name:"Apparel")
      @product = Product.new(description:"Fashion axe brooklyn austin bespoke tattooed gastr...", image: "apparel1.jpg", price_cents: 6499, quantity: 10)
      @product.category = @category
      @product.save
      #expect(@product.errors.full_messages).to be_present
      expect(@product.errors.full_messages).to include("Name can't be blank")
      expect(@product.name).to be_nil
    end
    it 'must have a price' do
      @category = Category.new(name:"Apparel")
      @product = Product.new(name:"Skirt",description:"Fashion axe brooklyn austin bespoke tattooed gastr...", image: "apparel1.jpg", quantity: 10)
      @product.category = @category
      @product.save
      #expect(@product.price_cents).to eq(7000)
      expect(@product.errors.full_messages).to include("Price is not a number")
      expect(@product.price).to be_nil
    end
    it 'must have a quantity' do
      @category = Category.new(name:"Apparel")
      @product = Product.new(name:"Skirt",description:"Fashion axe brooklyn austin bespoke tattooed gastr...", image: "apparel1.jpg", price_cents: 7000)
      @product.category = @category
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
      #expect(@product.quantity).to eq(10)
    end
    it 'must have a category' do
      #@category = Category.new()
      @product = Product.new(name:"Skirt",description:"Fashion axe brooklyn austin bespoke tattooed gastr...", image: "apparel1.jpg", price_cents: 7000, quantity: 10)
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end


# <Product id: 1, name: "Men's Classy shirt", description: "Fashion axe brooklyn austin bespoke tattooed gastr...", image: "apparel1.jpg", price_cents: 6499, quantity: 10, created_at: "2022-02-05 04:00:04", updated_at: "2022-02-05 04:00:04", category_id: 1> 
# 2.6.6 :002 >

#<Category id: 1, name: "Apparel", created_at: "2022-02-05 04:00:03", updated_at: "2022-02-05 04:00:03"> 