module Pubmed
  class ArticleQuery

    def initialize(scope)
      @scope = scope
      @terms = []
      @params = {
        :db     => 'pubmed'
      }
    end

    # the full query url with params
    def uri
      
    end

    # run the query and return the results?
    def execute
      # build the query string
      # run the query
      # return the results
    end

    # a term or array of terms
    def where(terms)
      if terms.is_a?(Array)
        @terms += terms
      else
        @terms << terms
      end
      @terms.uniq!
      self
    end

    # a hash of date options
    def dates(opts)
      if opts.is_a?(Hash)
        opts = { :datetype => 'pdate' }.merge(opts)
        @params.merge!(opts) 
      end
      self
    end

    # the offset into the collection
    # Pubmed param: retstart
    def offset(val)
      @params[:retstart] = val
      self
    end

    # the number of records to return
    # Pubmed param: retmax
    def limit(val)
      @params[:retmax] = val
      self
    end

    # sets the return type to 'count' instead of 'uilist'
    # so this just returns the count in the xml returned from Pubmed
    def count
      @params[:rettype] = 'count'
      self
    end

  end
end