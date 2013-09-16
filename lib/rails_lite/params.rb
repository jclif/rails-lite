require 'uri'

class Params
  def initialize(req, route_params)
    @req = req
    @route_params = route_params
    @params = get_params
  end

  def get_params
    parsed_route_params = @route_params ? parse_www_encoded_form(@route_params) : {}
    parsed_body_params = @req.body ? parse_www_encoded_form(@req.body) : {}

    params = parsed_route_params.merge(parsed_body_params)
    if params == {}
      nil
    else
      params
    end
  end

  def [](key)
  end

  def to_s
    @params.to_s
  end

  private
  def parse_www_encoded_form(www_encoded_form)
    params = {}
    deep_pairs = []

    URI.decode_www_form(www_encoded_form).each do |pair|
      deep_pairs << [parse_key(pair[0]), pair[1]]
    end

    deep_pairs.each do |pair|
      if pair[0].length == 1
        params[pair[0][0]] = pair[1]
      else
        next_hash = params
        until pair[0].length == 1
          shifted = pair[0].shift
          if next_hash[shifted].nil?
            next_hash[shifted] = {}
          end
          next_hash = params[shifted]
        end
        next_hash[pair[0][0]] = pair[1]
      end
    end

    params
  end

  def parse_key(key)
    key.split(/\]\[|\[|\]/)
  end
end
