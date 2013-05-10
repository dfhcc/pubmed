module Pubmed
  class EFetch < Query

    def self.fetch(ids, options={})
      return [] if ids.blank?
      response_xml = get_response(build_fetch_uri(ids, options))
      return parse_fetch_response(response_xml)
    end

  private

    def self.build_id_param(ids)
      ids.is_a?(Array) ? ids.join(',') : ids
    end

    def self.build_fetch_uri(ids, options)
      uri = URI.parse(EFETCH_URI)

      params = {
        :db => 'pubmed',
        :retmode => 'xml',
        :id => build_id_param(ids)
      }

      uri.query = encode_params(params, options)

      uri
    end

    def self.parse_fetch_response(response_xml)
      response_xml.xpath('./PubmedArticleSet/PubmedArticle').map { |element| Article.new(element) }
    end

  end
end