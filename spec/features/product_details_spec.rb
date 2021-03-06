require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do

  #setup
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "they see a single products info" do
    visit root_path

    first(".product").click_on "Details"

    sleep 5

    save_screenshot

    expect(page).to have_css 'section.products-show', count: 1
  end

end
