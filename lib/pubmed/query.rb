module Pubmed
  class Query

    def self.encode_params(params, options={})
      URI.encode_www_form(params.merge!(options))
    end

    def self.get_response(uri)
      result = Net::HTTP.get_response(uri)
      return Nokogiri::XML(result.body)
    end
    
  end
end