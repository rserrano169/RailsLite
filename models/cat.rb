class Cat
  attr_reader :name

  def self.all
    @cats ||= []
  end

  def initialize(params = {})
    params ||= {}
    @id = set_new_id
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

  def set_new_id
    used_ids = []
    Cat.all.each do |dog|
      used_ids << dog.id
    end

    id = 1
    while used_ids.include?(id)
      id += 1
    end

    id
  end
end
