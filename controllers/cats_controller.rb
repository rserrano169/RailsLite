require_relative '../controller_base/controller_base.rb'
require_relative '../models/cat.rb'

class CatsController < ControllerBase
  def index

  end

  def show

  end

  def new
    @cat = Cat.new
    render :new
  end

  def create

  end
end
