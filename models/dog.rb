class Dog
  attr_reader :name, :id

  def self.all
    @dogs ||= []
  end

  def self.find(dog_id)
    Dog.all.select {|dog| dog.id == dog_id.to_i}[0]
  end

  def initialize(params = {})
    params ||= {}
    @id = set_new_id
    @name = params["name"]
    @sentences = [
      "Hi!",
      "My name is #{@name}.",
      "I wanna play!",
      "I'm hungry!",
      "You're my best friend!",
      "I like talking.",
      "Grrr...",
      "WOOF!!!",
      "...woof..."
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

  def set_new_id
    used_ids = []
    Dog.all.each do |dog|
      used_ids << dog.id
    end

    id = 1
    while used_ids.include?(id)
      id += 1
    end

    id
  end
end
