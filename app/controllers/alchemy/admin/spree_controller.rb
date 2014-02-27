class Alchemy::Admin::SpreeController < Alchemy::Admin::BaseController
  def index
    authorize! :index, :alchemy_admin_spree
    render
  end
end
