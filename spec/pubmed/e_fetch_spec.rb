require 'spec_helper'

describe Pubmed::EFetch do
  before(:each) do
    @response_xml = Nokogiri::XML(File.open(File.expand_path('spec/fixtures/efetch_results.xml')))
    @expected_result = @response_xml.xpath('.//PubmedArticle').map { |element| Pubmed::Article.new(element) }
    Pubmed::EFetch.stub(:get_response).and_return(@response_xml)
  end

  describe '.build_fetch_uri' do
    it 'should build the fetch uri for the paramters' do
      ids = ['23650637', '23645694']
      expected = URI.parse(Pubmed::EFETCH_URI)
      expected.query = URI.encode_www_form({:db => 'pubmed', :retmode => 'xml', :id => ids.join(',')})
      Pubmed::EFetch.build_fetch_uri(ids, {}).should == expected
    end
  end
end