module Pubmed
  class Query

    def get_results(uri)
      result = Net::HTTP.get_response(uri)
      return Nokogiri::XML(result.body)
    end

  end
end