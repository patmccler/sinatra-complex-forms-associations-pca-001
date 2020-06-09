class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    owner = Owner.find(params[:pet_owner_id]) if params[:pet_owner_id]
    pet = Pet.create(name: params[:pet_name])

    owner = Owner.create(name: params["owner_name"]) unless params["owner_name"].empty?

    owner.pets << pet if owner

    redirect to "pets/#{pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do

    pet = Pet.find(params[:id])
    pet.update(name: params[:pet_name])

    owner = Owner.find(params[:pet_owner_id]) if params[:pet_owner_id]

    owner = Owner.create(params[:owner]) if params[:owner] && params[:owner][:name] != ""

    owner.pets << pet if owner

    redirect to "pets/#{@pet.id}"
  end
end