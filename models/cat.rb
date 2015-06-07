class Cat
  attr_reader :name

  def self.all
    @cats ||= []
  end

  def initialize(params = {})
    params ||= {}
    @name = params["name"]
    @sentences = [
      "...",
      "My name is #{@name}.",
      "Go Away.",
      "Fine. You can stay. For now.",
      "Bye.",
      "Zzzz...",
      "Pur-r-r-r..."
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

    Cat.all << self
    true
  end

  def meow(volume = "softly")
    if volume == "softly"
      "...meow..."
    elsif volume == "loudly"
      "MEEEEOOWWWW!"
    end
  end

  def speak
    @sentences.sample
  end
end
