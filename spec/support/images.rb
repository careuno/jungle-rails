# Helper function to open product images
def open_asset(file_name)
  File.open(Rails.root.join('db', 'seed_assets', file_name))
end

#Now let's add the image attribute to the product creation code in our scenario. For now we can be happy seeing the same image for all our products.

