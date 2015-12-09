class Alchemy::Admin::SolidusController < Alchemy::Admin::BaseController
  def index
    authorize! :index, :alchemy_admin_solidus
    render
  end
end
