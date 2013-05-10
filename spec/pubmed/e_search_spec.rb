require 'spec_helper'

describe Pubmed::ESearch do
  before(:each) do
    @response_xml = Nokogiri::XML(File.open(File.expand_path('spec/fixtures/esearch_results.xml')))
    @expected_result = Pubmed::SearchResult.new(8142, @response_xml.xpath('.//Id').map(&:text))
    Pubmed::ESearch.stub(:get_response).and_return(@response_xml)
  end

  describe '.build_search_uri' do
    it 'should build the search uri for the paramters' do
      term = 'test_term'
      expected = URI.parse(Pubmed::ESEARCH_URI)
      expected.query = URI.encode_www_form({:db => 'pubmed', :term => term, :retstart => 0, :retmax => 20})
      Pubmed::ESearch.build_search_uri(term, 0, 20, {}).should == expected
    end
  end

  describe '.parse_search_response' do
    it 'should return a SearchResult' do
      Pubmed::ESearch.parse_search_response(@response_xml).should == @expected_result
    end
  end

  context 'given an empty search term' do
    before(:each) { @result = Pubmed::ESearch.search('') }

    describe 'returned SearchResult object' do
      it 'should have a count of 0' do
        @result.count.should be_zero
      end

      it 'should have an empty pubmed_ids array' do
        @result.pubmed_ids.should be_empty
      end
    end
  end

  context 'given a search term' do
    before(:each) { @result = Pubmed::ESearch.search('some term') }

    it 'should return a SearchResult' do
      @result.should == @expected_result
    end
  end
end