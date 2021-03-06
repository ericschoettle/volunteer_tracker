require('capybara/rspec')
require('./app')
require('pry')
require('launchy')
Capybara.app = Sinatra::Application
set(:show_exception, false)

describe('volunteer_tracker_path', :type => :feature) do
  it "adds a project" do
    visit('/')
    within('#project') {fill_in("name", :with => "save the world")}
    click_button("Add the project")
    expect(page).to have_content('save the world')
  end

  it "adds a volunteer and a project, assigns that volunteer to the project, and removes that volunteer from the project" do
    visit('/')
    within('#volunteer') {fill_in("name", :with => "Sally")}
    click_button("Add the volunteer")
    within('#project') {fill_in("name", :with => "save the world")}
    click_button("Add the project")
    expect(page).to have_content('Sally')
    click_link('Sally')
    expect(page).to have_content('Projects that Sally is not working on save the world')
    check("save the world")
    click_button("Add Projects to Volunteer")
    expect(page).to have_content('Projects that Sally has committed to save the world')
    check("save the world")
    click_button("Delete Projects from volunteer")
    expect(page).to have_content('Projects that Sally is not working on save the world')
  end

  it "adds a leader" do
    visit('/')
    within('#leader') {fill_in("name", :with => "Bob")}
    click_button("Add the leader")
    expect(page).to have_content('Bob')
  end
end


  # click_button("Add the project")
  # expect(page).to have_content('Polar Express')
  # within('#volunteer') {fill_in("name", :with => "Chicago")}
  # find('#projectSelect').find(:xpath, 'option[1]').select_option
  # click_button("Add the volunteer")
  # expect(page).to have_content('danger')
  # click_link("urology")
