module Routes
  def create_routes(router)
    router.draw do
      get Regexp.new("^/$"), RootsController, :root
      get Regexp.new("^/dogs/new$"), DogsController, :new
      post Regexp.new("^/dogs$"), DogsController, :create
      get Regexp.new("^/dogs$"), DogsController, :index
      get Regexp.new("^/dogs/(?<id>\d+)$"), DogsController, :show
      get Regexp.new("^/cats/new$"), CatsController, :new
      post Regexp.new("^/cats$"), CatsController, :create
      get Regexp.new("^/cats$"), CatsController, :index
      get Regexp.new("^/cats/(?<id>\d+)$"), CatsController, :show
    end
  end
end
