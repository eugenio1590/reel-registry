require 'uri'
require 'net/http'
require 'json'

class NumbService
  API_URL = "https://www.random.org/integers/".freeze

  def self.generate_random_number(min:1, max:100, base: 10)
    uri = URI(API_URL)
    uri.query = URI.encode_www_form({
      num: 1,
      min: min,
      max: max,
      col: 1,
      base: base,
      format: "plain",
      rnd: "new"
    })

    response = Net::HTTP.get_response(uri)
    response.code == "200" ? response.body.to_i : nil
  end
end
