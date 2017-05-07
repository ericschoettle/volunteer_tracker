require 'sinatra'
require 'sinatra/reloader'
require './lib/project'
require './lib/volunteer'
require './lib/helper'
require './lib/leader'
require 'pry'
require 'pg'
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker"})

get('/') do
  @projects, @volunteers, @leaders = Helper.all()
  erb(:index)
end

post('/clear') do
  Helper.clear_db()
  @projects, @volunteers, @leaders = Helper.all()
  erb(:index)
end

post('/leader') do
  name = params[:name]
  new_leader = Leader.new({:name => name})
  new_leader.save()
  @projects, @volunteers, @leaders = Helper.all()
  erb(:index)
end

get('/leader/:id') do
  @leader = Leader.find(params[:id].to_i())
  erb(:leader)
end

patch("/leader/:id") do
  project_ids = params[:project_ids]
  @leader = Leader.find(params["id"].to_i())
  @leader.update_leader_projects({:project_ids => project_ids})
  erb(:leader)
end

patch("/leader") do
  leader = Leader.find(params["id"].to_i())
  leader.update_leader(params["name"])
  @leader = Leader.find(params["id"].to_i())
  erb(:leader)
end

delete("/leader/:id") do
  @leader = Leader.find(params["id"].to_i())
  @leader.delete_leader_projects(:project_ids => params["project_ids"])
  erb(:leader)
end

delete("/leader") do
  leader = Leader.find(params["id"].to_i())
  leader.delete_leader()
  @projects, @volunteers, @leaders = Helper.all()
  erb(:index)
end

post('/project') do
  name = params[:name]
  new_project = Project.new({:name => name})
  new_project.save()
  @projects, @volunteers, @leaders = Helper.all()
  erb(:index)
end

get('/project/:id') do
  @project = Project.find(params[:id].to_i())
  erb(:project)
end

patch("/project/:id") do
  @project = Project.find(params["id"].to_i())
  @project.update_projects_volunteers({:volunteer_ids => params[:volunteer_ids], :times => params[:times]})
  erb(:project)
end

patch("/project") do
  project = Project.find(params["id"].to_i())
  project.update_project(params["name"])
  @project = Project.find(params["id"].to_i())
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
  @projects, @volunteers, @leaders = Helper.all()
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
  @projects, @volunteers, @leaders = Helper.all()
  erb(:index)
end

patch("/volunteer/:id") do
  @volunteer = Volunteer.find(params["id"].to_i())
  @volunteer.update_projects_volunteers(params[:project_ids])
  erb(:volunteer)
end

patch("/volunteer") do
  volunteer = Volunteer.find(params["id"].to_i())
  volunteer.update_volunteer(params["name"])
  @volunteer = Volunteer.find(params["id"].to_i())
  erb(:volunteer)
end

delete("/volunteer/:id") do
  @volunteer = Volunteer.find(params["id"].to_i())
  @volunteer.delete_projects_volunteers(params["project_ids"])
  erb(:volunteer)
end

delete("/volunteer") do
  volunteer = Volunteer.find(params["id"].to_i())
  volunteer.delete_volunteer()
  @projects, @volunteers, @leaders = Helper.all()
  erb(:index)
end
