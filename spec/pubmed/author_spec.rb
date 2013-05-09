require 'spec_helper'

describe Pubmed::Author do
  before(:each) do
    @articles = Nokogiri::XML(File.open(File.expand_path('spec/fixtures/efetch_results.xml'))).xpath('//PubmedArticle')
    @article = @articles.first
    @author = Pubmed::Author.new(@article.xpath('./MedlineCitation/Article/AuthorList/Author').first)
  end

  describe '#last_name' do
    it 'should be set to the value in the retrieved xml' do
      @author.last_name.should == @article.xpath('./MedlineCitation/Article/AuthorList/Author[1]/LastName').text
    end
  end

  describe '#fore_name' do
    it 'should be set to the value in the retrieved xml' do
      @author.fore_name.should == @article.xpath('./MedlineCitation/Article/AuthorList/Author[1]/ForeName').text
    end
  end

  describe '#initials' do
    it 'should be set to the value in the retrieved xml' do
      @author.initials.should == @article.xpath('./MedlineCitation/Article/AuthorList/Author[1]/Initials').text
    end
  end

  describe '#name' do
    it 'should return the last name with the initials' do
      last_name = @article.xpath('./MedlineCitation/Article/AuthorList/Author[1]/LastName').text
      initials = @article.xpath('./MedlineCitation/Article/AuthorList/Author[1]/Initials').text
      @author.name.should == "#{last_name} #{initials}"
    end
  end

  describe '#full_name' do
    it 'should return the last name and the fore name' do
      last_name = @article.xpath('./MedlineCitation/Article/AuthorList/Author[1]/LastName').text
      fore_name = @article.xpath('./MedlineCitation/Article/AuthorList/Author[1]/ForeName').text
      @author.full_name.should == "#{last_name} #{fore_name}"
    end
  end
end