class ProjectsController < ApplicationController

  get '/projects' do
    if !logged_in?
      redirect '/login'
    else
      @projects = Project.all
      erb :'projects/index'
    end
  end

  get '/projects/new' do
    if logged_in?
      erb :'projects/new'
    else
      redirect '/signup'
    end
  end

  post '/projects/new' do
    if !params.has_value?("")
      @employee = current_employee
      @project = Project.create(name:params[:name],description:params[:description],hours:params[:hours].to_i)
      @employee.projects << @project
      erb :'projects/show'
    else
      redirect '/projects/new'
    end
  end

  get '/projects/:id' do
    if logged_in?
      @project = Project.all.detect {|project| project.employee_id == current_employee.id}
      erb :'projects/show'
    else
      redirect '/signup'
    end
  end

end
