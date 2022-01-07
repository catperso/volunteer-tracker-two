require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

DB = PG.connect({ dbname: 'volunteer_tracker_test', host: 'db', user: 'postgres', password: 'password' })

describe('visits home page', {:type => :feature}) do
  it('should visit the home page') do
    visit('/')
    expect(page).to have_content("Project Coordinatizer!")
  end
end

describe('the project creation path', {:type => :feature}) do
  it('takes the user to the homepage where they can create a project') do
    visit('/')
    click_link('Start a new project!')
    fill_in('new_project', :with => 'Teaching Kids to Code')
    click_button('Start the project!')
    expect(page).to have_content('Teaching Kids to Code')
  end
end

describe('the project update path', {:type => :feature}) do
  it('allows a user to change the name of the project') do
    test_project = Project.new({title: 'Teaching Kids to Code', id: nil})
    test_project.save
    visit('/')
    click_link('Teaching Kids to Code')
    click_link('Edit this project')
    fill_in('project_update', :with => 'Teaching Ruby to Kids')
    click_button('Rename project!')
    expect(page).to have_content('Teaching Ruby to Kids')
  end
end

describe('the project delete path', {:type => :feature}) do
  it('allows a user to delete a project') do
    test_project = Project.new({title: 'Teaching Kids to Code', id: nil})
    test_project.save
    id = test_project.id
    visit("/projects/#{id}/edit")
    click_button('Remove this project and all its volunteers?')
    visit('/')
    expect(page).not_to have_content("Teaching Kids to Code")
  end
end

describe('the volunteer detail page path', {:type => :feature}) do
  it('shows a volunteer detail page') do
    test_project = Project.new({title: 'Teaching Kids to Code', id: nil})
    test_project.save
    project_id = test_project.id.to_i
    test_volunteer = Volunteer.new({name: 'Jasmine', project_id: project_id, id: nil})
    test_volunteer.save
    visit("/projects/#{project_id}")
    click_link('Jasmine')
    fill_in('volunteer_update', :with => 'Jane')
    click_button('Rename volunteer')
    expect(page).to have_content('Jane')
  end
end