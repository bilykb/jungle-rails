require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do
    context 'When creating a new Product' do
      it "is valid with valid attributes" do
        product = Product.new(name: "Electric Wooden Stick", price: 100000, quantity: 10, category: Category.new(name: "Electronics"))

        expect(product).to be_valid
      end

      it "is not valid without a name" do
        product = Product.create(name: nil, price: 100000, quantity:10, category: Category.new(name: "Electronics"))

        expect(product.errors.full_messages).to eq(["Name can't be blank"])
      end

      it "is not valid without a price" do
        product = Product.create(name: "Electric Wooden Stick", price: nil, quantity: 10, category: Category.new(name: "Electronics"))

        expect(product.price).to eq(0)
      end

      it "is not valid without a quantity" do
        product = Product.create(name: "Electric Wooden Stick", price: 100000, quantity: nil, category: Category.new(name: "Electronics"))
        
        expect(product.errors.full_messages).to eq(["Quantity can't be blank"])
      end
    end
  end
end
