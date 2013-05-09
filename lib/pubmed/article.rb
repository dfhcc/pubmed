module Pubmed
  class Article

    def self.fetch(*args)
      get_fetch_results(args.flatten)
    end

    def initialize(element)
      @element = element
    end

    def pubmed_id
      @pubmed_id ||= @element.xpath('.//PMID').text
    end

    def publication_date
      @publication_date ||= build_publication_date
    end

    def title
      @title ||= @element.xpath('.//Article/ArticleTitle').text
    end

    def abstract
      @abstract ||= @element.xpath('.//Article/Abstract/AbstractText').text
    end

    def journal
      @journal ||= Journal.new(@element.xpath('.//Article/Journal').first)
    end

    def authors
      @authors ||= build_authors
    end

    def author_names
      @author_names ||= build_author_names
    end

  private

    def self.get_results(uri)
      result = Net::HTTP.get_response(uri)
      return Nokogiri::XML(result.body)
    end

    def self.get_fetch_results(pubmed_ids)
      results = get_results(build_fetch_uri(pubmed_ids))
      return results.xpath('.//PubmedArticle').map { |element| Article.new(element) }
    end

    def self.build_fetch_uri(pubmed_ids)
      uri = URI.parse(EFETCH_URI)

      params = {
        :db => 'pubmed',
        :retmode => 'xml',
        :id => pubmed_ids.join(',')
      }

      uri.query = URI.encode_www_form(params)
      uri
    end

    def self.get_search_results(terms, options={})
      results = get_results(build_search_uri(terms))
      if results.xpath('.//Id').any?
        pubmed_ids = results.xpath('.//Id').map { |id_element| id_element.text }
        get_fetch_results(pubmed_ids)
      else
        results.xpath('.//Count').text
      end
    end

    def self.build_search_uri(terms, options={})
      uri = URI.parse(ESEARCH_URI)

      params = {
        :db => 'pubmed',
        :term => ''
      }

      uri.query = URI.encode_www_form(params)
      uri
    end

    def build_publication_date
      year = @element.xpath('.//DateCreated/Year').text
      month = @element.xpath('.//DateCreated/Month').text
      day = @element.xpath('.//DateCreated/Day').text
      date_str = "#{year}-#{month}-#{day}"
      date = Date.parse(date_str)
    end

    def build_authors
      @element.xpath('.//Article/AuthorList/Author').map { |element| Author.new(element) }
    end

    def build_author_names
      authors.map(&:name).join(', ')
    end

  end
end