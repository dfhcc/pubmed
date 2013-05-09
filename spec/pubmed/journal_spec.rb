require 'spec_helper'

describe Pubmed::Journal do
  before(:each) do
    @articles = Nokogiri::XML(File.open(File.expand_path('spec/fixtures/efetch_results.xml'))).xpath('//PubmedArticle')
    @article = @articles.first
    @journal = Pubmed::Journal.new(@article.xpath('./MedlineCitation/Article/Journal').first)
  end

  describe '#title' do
    it 'should be set to the value in the retrieved xml' do
      @journal.title.should == @article.xpath('./MedlineCitation/Article/Journal/Title').text
    end
  end

  describe '#abbreviation' do
    it 'should be set to the value in the retrieved xml' do
      @journal.abbreviation.should == @article.xpath('./MedlineCitation/Article/Journal/ISOAbbreviation').text
    end
  end
end