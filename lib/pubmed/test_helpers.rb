module Pubmed
  module TestHelpers

    def mock_article(pubmed_id, title, abstract, publication_date, journal=nil, authors=[])
      article = Article.new(nil)
      article.stub(:pubmed_id).and_return(pubmed_id)
      article.stub(:title).and_return(title)
      article.stub(:abstract).and_return(abstract)
      article.stub(:publication_date).and_return(publication_date)
      article.stub(:journal).and_return(journal)
      article.stub(:authors).and_return(authors)
      article
    end

    def mock_journal(title, abbreviation)
      journal = Journal.new(nil)
      journal.stub(:title).and_return(title)
      journal.stub(:abbreviation).and_return(abbreviation)
      journal
    end

    def mock_author(last_name, fore_name, initials)
      author = Author.new(nil)
      author.stub(:last_name).and_return(last_name)
      author.stub(:fore_name).and_return(fore_name)
      author.stub(:initials).and_return(initials)
      author
    end

  end
end