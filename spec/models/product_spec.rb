require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should not save without a valid name' do
      category = Category.new
      product = Product.new(name: nil, price: 999, quantity: 1, category: category)
      product.save
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should not save without a valid price' do
      category = Category.new
      product = Product.new(name: "tree o life", price: "asfsdf", quantity: 1, category: category)
      product.save
      expect(product.errors.full_messages).to include("Price is not a number")
    end

    it 'should not save without a valid quantity' do
      category = Category.new
      product = Product.new(name: "tree o life", price: 444, quantity: nil, category: category)
      product.save
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should not save without a valid category' do
      product = Product.new(name: "tree o life", price: 999, quantity: 1, category: nil)
      product.save
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end


# validates :name, presence: true
# validates :price, presence: true
# validates :quantity, presence: true
# validates :category, presence: true