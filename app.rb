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