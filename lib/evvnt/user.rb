# Fetch EVVNT Users from the API
class Evvnt::User < Evvnt::Base

  ##
  # POST /users Create a user
  define_action :create


  ##
  # GET /users Get a list of all users created by you
  define_action :index

  ##
  # GET /users/:user_id Get details of a user
  define_action :show


  ##
  # PUT /users/:user_id Update a user
  define_action :update

end
