require 'sinatra'
require 'sinatra/reloader'
also_reload 'lib/**/*.rb'
require 'pry'
require 'pg'
require './lib/project'
require './lib/volunteer'

DB = PG.connect({ dbname: 'volunteer_tracker', host: 'db', user: 'postgres', password: 'password' })

get('/') do
  @projects = Project.all
  redirect to('/projects')
end

get('/projects') do
  @projects = Project.all
  erb(:projects)
end

delete('/projects') do
  Project.clear
  Volunteer.clear
  redirect to('/projects')
end

get('/projects/new') do
  erb(:new_project)
end

post('/projects') do
  project = Project.new({title: params[:new_project]})
  project.save
  redirect to('/projects')
end

get('/projects/:id') do
  @project = Project.find(params[:id].to_i)
  erb(:project)
end

post('/projects/:id/volunteers') do
  @project = Project.find(params[:id].to_i)
  volunteer = Volunteer.new({name: params[:new_volunteer], project_id: @project.id})
  volunteer.save
  erb(:project)
end

get('/projects/:id/edit') do
  @project = Project.find(params[:id].to_i)
  erb(:edit_project)
end

patch('/projects/:id') do
  @project = Project.find(params[:id].to_i)
  @project.update({title: params[:project_update]})
  erb(:edit_project)
end

delete('/projects/:id') do
  project = Project.find(params[:id].to_i)
  project.delete
  redirect to('/')
end

get('/projects/:project_id/volunteers/:id') do
  @project = Project.find(params[:project_id].to_i)
  @volunteer = Volunteer.find(params[:id].to_i)
  erb(:volunteer)
end

patch('/projects/:project_id/volunteers/:id') do
  @project = Project.find(params[:project_id].to_i)
  volunteer = Volunteer.find(params[:id].to_i)
  volunteer.update({name: params[:volunteer_update]})
  erb(:project)
end

delete('/projects/:project_id/volunteers/:id') do
  volunteer = Volunteer.find(params[:id].to_i)
  volunteer.delete
  @project = Project.find(params[:project_id].to_i)
  erb(:project)
end