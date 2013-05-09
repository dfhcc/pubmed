module Pubmed
  class Query

    def self.get_response(uri)
      result = Net::HTTP.get_response(uri)
      return Nokogiri::XML(result.body)
    end

  end
end