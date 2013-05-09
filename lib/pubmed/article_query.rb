module Pubmed
  class ArticleQuery

    def initialize(scope)
      @scope = scope
    end

    # run the query and return the results?
    def execute
      # Run the query
    end

    # args
    # can be an Array or Hash
    # when Array it is a list of terms
    # when Hash it is {
    #                   :terms => ['id1',...,'idn'], 
    #                   :dates => { :datetype => 'pdate|mdate|edate', 
    #                               :mindate => 'YYYY/MM/DD|YYYY/MM|YYYY', 
    #                               :maxdate => 'YYYY/MM/DD|YYYY/MM|YYYY' }
    #                 }
    def where(args)
      # TODO
      self
    end

    # the offset into the collection
    # Pubmed param: retstart
    def offset(val)
      # TODO
      self
    end

    # the number of records to return
    # Pubmed param: retmax
    def limit(val)
      # TODO
      self
    end

    # sets the return type to 'count' instead of 'uilist'
    # so this just returns the count in the xml returned from Pubmed
    def count
      # TODO
      self
    end

  end
end