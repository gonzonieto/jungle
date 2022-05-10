require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'successfully saves a product that has a name, category, price, and quantity' do
      product = Product.new(
        name: 'Pointsettia',
        category: Category.new,
        price: 1299,
        quantity: 30
      )
      product.validate
      expect(product.errors.full_messages).to be_empty
    end

    it 'does not save a product that is missing a name' do
      product = Product.new(
        category: Category.new,
        price: 1299,
        quantity: 30
      )
      product.validate
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'does not save a product that is missing a category' do
      product = Product.new(
        name: 'Pointsettia',
        price: 1299,
        quantity: 30
      )
      product.validate
      expect(product.errors.full_messages).to include("Category can't be blank", "Category must exist")
    end

    it 'does not save a product that is missing a price' do
      product = Product.new(
        name: 'Pointsettia',
        category: Category.new,
        quantity: 30
      )
      product.validate
      expect(product.errors.full_messages).to include("Price cents is not a number", "Price is not a number", "Price can't be blank")
    end

    it 'does not save a product that is missing a quantity' do
      product = Product.new(
        name: 'Pointsettia',
        category: Category.new,
        price: 1299
      )
      product.validate
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end
  end
end
