require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
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

  scenario "Logged in user can add item to cart, cart increments +1" do
    visit new_session_path

    user = User.create(email: "fun_stuff@gmail.com", password: "string_password", password_confirmation: "string_password")

    fill_in 'email', with: 'fun_stuff@gmail.com'
    fill_in 'password', with: 'string_password'

    click_on "Submit"

    within('#navbar') { expect(page).to have_content("My Cart (0)") }

    first(".product").click_on "Add"
    
    save_screenshot

    within('#navbar') { expect(page).to have_content("My Cart (1)") }
  end
end
