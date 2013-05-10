module Pubmed
  class ESearch < Query

    def self.search(terms, offset=0, limit=20, options={})
      return SearchResult.new(0, []) if terms.blank?
      response_xml = get_response(build_search_uri(terms, offset, limit, options))
      return parse_search_response(response_xml)
    end

  private

    def self.build_search_uri(terms, offset, limit, options)
      term = terms.is_a?(Array) ? terms.join('+AND+') : terms

      uri = URI.parse(ESEARCH_URI)

      params = {
        :db => 'pubmed',
        :term => term,
        :retstart => offset,
        :retmax => limit
      }

      params.merge!(options)

      uri.query = URI.encode_www_form(params)

      uri
    end

    def self.parse_search_response(response_xml)
      count = response_xml.xpath('.//Count').text.to_i
      pubmed_ids = response_xml.xpath('.//Id').map { |id_element| id_element.text }
      return SearchResult.new(count, pubmed_ids)
    end

  end
end