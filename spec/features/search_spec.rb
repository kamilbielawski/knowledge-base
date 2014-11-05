require 'spec_helper'

feature 'Searching for topics', js: true do
  let!(:topic) { create :topic }
  let!(:resource) { create :resource }
  let!(:resource2) { create :resource }

  scenario 'finding topics' do
    visit '/'
    fill_in 'keywords', with: topic.name
    click_on 'Search'

    expect(page).to have_content(resource.name)
    expect(page).to have_content(resource2.name)
  end
end
