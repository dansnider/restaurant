class PartiesController < ApplicationController

  get "/" do
    @parties = Party.all
    erb :"parties/index"
  end

  get "/new" do
      erb :'parties/new'
  end

  post "/" do
    party = Party.create(params[:party])
    redirect to "/parties/#{party.id}"
  end

  get "/:id" do
    @party = Party.find( params[:id] )
    erb :"parties/show"
  end

  get "/:id/edit" do
    @party = Party.find( params[:id] )
    erb :"parties/edit"
  end

  patch '/:id' do
    party = Party.find(params[:id])
    party.update(params[:food])

    redirect to "/parties/#{party.id}"
  end

  delete '/:id' do
    party = Party.find(params[:id])
    party.destroy

    redirect to "/"
  end
end