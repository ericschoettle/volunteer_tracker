require 'sinatra'
require 'sinatra/reloader'
require './lib/project'
require './lib/volunteer'
require './lib/helper'
require 'pry'
require 'pg'
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker"})

get('/') do
  @projects = Project.all()
  @volunteers = Volunteer.all()
  erb(:index)
end

post('/clear') do
  Helper.clear_db()
  @projects = Project.all()
  @volunteers = Volunteer.all()
  erb(:index)
end

get('/project/:id') do
  @project = Project.find(params[:id].to_i())
  erb(:project)
end

post('/project') do
  name = params[:name]
  new_project = Project.new({:name => name})
  new_project.save()
  @projects = Project.all()
  @volunteers = Volunteer.all()
  erb(:index)
end

patch("/project/:id") do
  binding.pry
  @project = Project.find(params["id"].to_i())
  @project.update_projects_volunteers({:volunteer_ids => params[:volunteer_ids], :times => params[:times]})
  erb(:project)
end

delete("/project/:id") do
  @project = Project.find(params["id"].to_i())
  @project.delete_projects_volunteers(params["volunteer_ids"])
  erb(:project)
end

delete("/project") do
  project = Project.find(params["id"].to_i())
  project.delete_project()
  @projects = Project.all()
  @volunteers = Volunteer.all()
  erb(:index)
end

get("/volunteer/:id") do
  @volunteer = Volunteer.find(params["id"].to_i())
  erb(:volunteer)
end

post('/volunteer') do
  name = params[:name]
  project_id = params[:project].to_i()
  new_volunteer = Volunteer.new({:name => name, :project_id => project_id})
  new_volunteer.save()
  @projects = Project.all()
  @volunteers = Volunteer.all()
  erb(:index)
end

patch("/volunteer/:id") do
  @volunteer = Volunteer.find(params["id"].to_i())
  @volunteer.update_projects_volunteers(params[:project_ids])
  erb(:volunteer)
end

delete("/volunteer/:id") do
  @volunteer = Volunteer.find(params["id"].to_i())
  @volunteer.delete_projects_volunteers(params["project_ids"])
  erb(:volunteer)
end

delete("/volunteer") do
  volunteer = Volunteer.find(params["id"].to_i())
  binding.pry
  volunteer.delete_volunteer()
  @projects = Project.all()
  @volunteers = Volunteer.all()
  erb(:index)
end
