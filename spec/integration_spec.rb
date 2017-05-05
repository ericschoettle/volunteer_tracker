require('capybara/rspec')
require('./app')
require('pry')
require('launchy')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)


  # it "selects project index function, adds project, volunteer, and a project_volunteer" do
  #   visit('/')
  #   within('#project') {fill_in("name", :with => "Polar Express")}
  #   click_button("Add the project")
  #   expect(page).to have_content('Polar Express')
  #   within('#volunteer') {fill_in("name", :with => "Chicago")}
  #   find('#projectSelect').find(:xpath, 'option[1]').select_option
  #   click_button("Add the volunteer")
  #   expect(page).to have_content('danger')
  #   click_link("urology")
  # end
