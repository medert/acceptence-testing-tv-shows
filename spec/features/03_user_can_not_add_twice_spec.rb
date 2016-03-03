require 'spec_helper'
require 'launchy'
# As an organized TV fanatic
# I want to receive an error message if I try to add the same show twice
# So that I don't have duplicate entries

# Acceptance Criteria:
# [] If the title is the same as a show that I've already added, the details are not saved to the csv
# [] If the title is the same as a show that I've already added, I will be shown an error that says "The show has already been added".
# [] If the details of the show are not saved, I will remain on the new form page


feature "user add a duplicate show" do
  scenario "user adds a dublicate show unsuccessfully" do
    visit "/television_shows/new"

    fill_in "Title", with: "Friends"
    fill_in "Network", with: "NBC"
    fill_in "Starting Year", with: "1994"
    fill_in "Synopsis", with: "Six friends living in New York city."
    select "Comedy", from: "Genre"

    click_button "Add TV Show"

    expect(page).to have_content "List of Shows"
    visit "/television_shows/new"

    fill_in "Title", with: "Friends"
    fill_in "Network", with: "NBC"
    fill_in "Starting Year", with: "1994"
    fill_in "Synopsis", with: "Six friends living in New York city."
    select "Comedy", from: "Genre"

    click_button "Add TV Show"
    expect(page).to have_content "New"
    save_and_open_page

  end

end
