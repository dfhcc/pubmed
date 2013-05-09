module Pubmed
  class Article

    def self.fetch(*args)
      
    end

    def self.search(*args)

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