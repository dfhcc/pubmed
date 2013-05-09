module Pubmed
  class Author

    def initialize(element)
      @element = element
    end

    def last_name
      @last_name ||= @element.xpath('./LastName').text
    end

    def fore_name
      @fore_name ||= @element.xpath('./ForeName').text
    end

    def initials
      @initials ||= @element.xpath('./Initials').text
    end

    def name
      @name ||= "#{last_name} #{initials}"
    end

    def full_name
      @full_name ||= "#{last_name} #{fore_name}"
    end

    def ==(other)
      self.last_name == other.last_name &&
      self.fore_name == other.fore_name &&
      self.initials == other.initials
    end

  end
end