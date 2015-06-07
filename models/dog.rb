class Dog
  attr_reader :name

  def self.all
    @dogs ||= []
  end

  def initialize(params = {})
    params ||= {}
    @name = params["name"]
    @sentences = [
      "Hi!",
      "My name is #{@name}.",
      "I wanna play!",
      "I'm hungry!",
      "You're my best friend!",
      "I like talking.",
      "Grrr..."
    ]
  end

  def errors
    @errors ||= []
  end

  def valid?
    unless @name.present?
      errors << "Must have a name."
      return false
    end

    true
  end

  def save
    return false unless valid?

    Dog.all << self
    true
  end

  def bark(volume = "loudly")
    if volume == "loudly"
      "WOOF!!!"
    elsif volume == "softly"
      "...woof..."
    end
  end

  def speak
    @sentences.sample
  end
end
