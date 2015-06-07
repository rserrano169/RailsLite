require_relative '../controller_base/controller_base.rb'
require_relative '../models/dog.rb'

class DogsController < ControllerBase
  def index
    @dogs = Dog.all
    render :index
  end

  def show

  end

  def new
    @dog = Dog.new
    render :new
  end

  def create

  end
end
