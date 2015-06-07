class Params
  def initialize(req, route_params = {})
    @params = route_params
    if req.query_string
      @params.merge!(parse_www_encoded_form(req.query_string))
    end

    if req.body
      @params.merge!(parse_www_encoded_form(req.body))
    end
  end

  def [](key)
    @params[key.to_s]
  end

  # this will be useful if we want to `puts params` in the server log
  def to_s
    @params.to_s
  end

  class AttributeNotFoundError < ArgumentError; end;

  private

  def parse_www_encoded_form(www_encoded_form)
    params = Hash.new {|h, k| h[k] = Hash.new(&h.default_proc)}

    keys, vals = [], []
    URI.decode_www_form(www_encoded_form).each do |key, val|
      keys << key
      vals << val
    end

    keys.map! {|k| parse_key(k)}
    keys.each_with_index do |key, idx|
      key_str = ""
      key.each do |k|
        key_str += "['#{k}']"
      end
      eval("params#{key_str} = '#{vals[idx]}'")
    end

    return params
  end

  def parse_key(key)
    return key.split(/\]\[|\[|\]/)
  end
end
