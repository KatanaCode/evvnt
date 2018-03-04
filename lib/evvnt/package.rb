# Public: Represents the packages resources on the EVVNT API.
class Evvnt::Package < Evvnt::Base

  ##
  # GET /users/:user_id/packages Lists all of the packages belonging to a user
  define_action :index

  ##
  # POST /packages Create a package
  define_action :create

  ##
  # GET /packages/:package_id Get the details of a package
  define_action :show

  ##
  # GET /packages/mine List my packages
  define_action :mine

  belongs_to :user

end
