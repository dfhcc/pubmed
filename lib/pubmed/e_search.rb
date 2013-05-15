module Pubmed
  class ESearch < Query

    def self.search(terms, offset=0, limit=20, options={})
      return SearchResult.new(0, []) if terms.blank?
      response_xml = get_response(build_search_uri(terms, offset, limit, options))
      return parse_search_response(response_xml)
    end

  private

    def self.build_term_param(terms)
      terms.is_a?(Array) ? terms.join('+AND+') : terms
    end

    def self.querystringify(hash)
      hash.map do |opt, val|
        val = val.tr(' ', '+') if val.is_a?(String)
        URI.escape("#{opt}=#{val}")
      end.join('&')
    end

    def self.build_search_uri(terms, offset, limit, options)
      params = {
        :db => 'pubmed',
        :term => build_term_param(terms),
        :retstart => offset,
        :retmax => limit
      }

      query = querystringify(params)

      uri = URI.parse(ESEARCH_URI + '?' + query)

      uri
    end

    def self.parse_search_response(response_xml)
      count = response_xml.xpath('.//Count').first.text.to_i
      pubmed_ids = response_xml.xpath('.//Id').map(&:text)
      return SearchResult.new(count, pubmed_ids)
    end
  end
end