require 'active_support/core_ext'
require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'date'

require 'pubmed/version'
require 'pubmed/article_query'
require 'pubmed/article'
require 'pubmed/journal'
require 'pubmed/author'
require 'pubmed/query'
require 'pubmed/e_search'
require 'pubmed/e_fetch'

module Pubmed
  BASE_URI = 'http://eutils.ncbi.nlm.nih.gov/entrez/eutils/'
  ESEARCH_URI = BASE_URI + 'esearch.fcgi'
  EFETCH_URI  = BASE_URI + 'efetch.fcgi'

  SearchResult = Struct.new(:count, :pubmed_ids)

  def self.search(terms, offset=0, limit=20, options={})
    ESearch.search(terms, offset, limit, options)
  end

  def self.fetch(ids, options={})
    EFetch.fetch(ids, options)
  end

  def self.search_and_fetch(terms, offset=0, limit=20, search_options={}, fetch_options={})
    search_result = search(terms, offset, limit, search_options)
    fetch(search_result.pubmed_ids, fetch_options)
  end
end
