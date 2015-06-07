require_relative '../../config/controller_base/controller_base.rb'

class RootsController < ControllerBase
  def root
    render :root
  end
end
