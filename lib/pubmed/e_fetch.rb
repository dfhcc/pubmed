module Pubmed
  class EFetch < Query

    def self.fetch(ids, options={})
      return [] if ids.blank?
      response_xml = get_response(build_fetch_uri(ids, options))
      return parse_fetch_response(response_xml)
    end

  private

    def build_fetch_uri(ids, options)
      ids = ids.join(',') if pubmed_ids.is_a?(Array)

      uri = URI.parse(EFETCH_URI)

      params = {
        :db => 'pubmed',
        :retmode => 'xml',
        :id => ids
      }

      params.merge!(options)

      uri.query = URI.encode_www_form(params)

      uri
    end

    def self.parse_fetch_response(response_xml)
      response_xml.xpath('./PubmedArticleSet/PubmedArticle')
    end

  end
end