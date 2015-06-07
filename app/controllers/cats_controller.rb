require_relative '../../config/controller_base/controller_base.rb'
require_relative '../models/cat.rb'

class CatsController < ControllerBase
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params["id"])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(params["cat"])

    if @cat.save
      redirect_to "/cats"
    else
      render :new
    end
  end
end
