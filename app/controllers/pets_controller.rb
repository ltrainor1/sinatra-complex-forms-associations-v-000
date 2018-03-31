class PetsController < ApplicationController
require 'pry'
  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    if params[:owner_name] != ""
      @owner = Owner.create(name: params[:owner_name])
      @pet = Pet.create(name: params[:pet][:name], owner_id: @owner.id)
    else
      @pet = Pet.create(name: params[:pet][:name], owner_id: params[:owner][:ids][0])
    end
    redirect "/pets/#{@pet.id}"
  end

  get '/pets/:id' do

    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    binding.pry
    @owner = Owner.find_by(params[:id])
    @pet = Pet.update(params[:id], {name: params[:pet_name], owner: @owner})
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end


end
