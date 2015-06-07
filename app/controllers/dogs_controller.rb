require_relative '../../config/controller_base/controller_base.rb'
require_relative '../models/dog.rb'

class DogsController < ControllerBase
  def index
    @dogs = Dog.all
    render :index
  end

  def show
    @dog = Dog.find(params["id"])
    render :show
  end

  def new
    @dog = Dog.new
    render :new
  end

  def create
    @dog = Dog.new(params["dog"])

    if @dog.save
      redirect_to "/dogs"
    else
      render :new
    end
  end
end
