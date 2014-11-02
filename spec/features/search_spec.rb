require 'spec_helper'

feature 'Searching for topics', js: true do
  before :each do
    create :topic, name: 'Ruby'
    create :topic, name: 'Ruby on Rails'
    create :topic, name: 'JavaScript'
    create :topic, name: 'Angular Js'
  end

  scenario 'finding topics' do
    visit '/'
    fill_in 'keywords', with: 'ruby'
    click_on 'Search'

    expect(page).to have_content('Ruby')
    expect(page).to have_content('Ruby on Rails')
  end
end
