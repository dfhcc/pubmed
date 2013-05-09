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

module Pubmed
  BASE_URI = 'http://eutils.ncbi.nlm.nih.gov/entrez/eutils/'
  ESEARCH_URI = BASE_URI + 'esearch.fcgi'
  EFETCH_URI  = BASE_URI + 'efetch.fcgi'
end
