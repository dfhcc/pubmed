module Pubmed
  class Journal

    def initialize(element)
      @element = element
    end

    def title
      @title ||= @element.xpath('./Title').text
    end

    def abbreviation
      @abbreviation ||= @element.xpath('./ISOAbbreviation').text
    end

    def ==(other)
      self.title == other.title &&
      self.abbreviation == other.abbreviation
    end

  end
end