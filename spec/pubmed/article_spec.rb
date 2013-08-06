require 'spec_helper'

describe Pubmed::Article do
  before(:each) do
    @articles = Nokogiri::XML(File.open(File.expand_path('spec/fixtures/efetch_results.xml'))).xpath('//PubmedArticle')
    @article_element = @articles.first
    @article = Pubmed::Article.new(@article_element)
  end

  describe '#pubmed_id' do
    it 'should be set to the value in the retrieved xml' do
      @article.pubmed_id.should == @article_element.xpath('.//PMID').text
    end
  end

  describe '#pubmed_central_id' do
    it 'should be set to the value in the retrieved xml' do
      @article.pubmed_central_id.should == @article_element.xpath('.//PubmedData/ArticleIdList/ArticleId[@IdType="pmc"]').text
    end
  end

  describe '#publication_date' do
    it 'should be set to the value in the retrieved xml' do
      year = @article_element.xpath('.//DateCreated/Year').text
      month = @article_element.xpath('.//DateCreated/Month').text
      day = @article_element.xpath('.//DateCreated/Day').text
      date_str = "#{year}-#{month}-#{day}"
      date = Date.parse(date_str)
      @article.publication_date.should == date
    end
  end

  describe '#title' do
    it 'should be set to the value in the retrieved xml' do
      @article.title.should == @article_element.xpath('.//Article/ArticleTitle').text
    end
  end

  describe '#abstract' do
    it 'should be set to the value in the retrieved xml' do
      @article.abstract.should == @article_element.xpath('.//Article/Abstract/AbstractText').text
    end
  end

  describe '#journal' do
    it 'should return a Journal object from the retrieved xml' do
      @article.journal.should == Pubmed::Journal.new(@article_element.xpath('.//Article/Journal').first)
    end
  end

  describe '#authors' do
    it 'should return an array of Author objects' do
      expected_authors = @article_element.xpath('.//Article/AuthorList/Author').map { |element| Pubmed::Author.new(element) }
      @article.authors.should == expected_authors
    end
  end

  describe '#author_names' do
    it 'should return a string representing the author names' do
      authors = @article_element.xpath('.//Article/AuthorList/Author').map { |element| Pubmed::Author.new(element) }
      expected_author_names = authors.map(&:name).join(', ')
      @article.author_names.should == expected_author_names
    end
  end
end