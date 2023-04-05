class WordsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
    @words = []
    if params[:q].present?
      @query = params[:q]
      # needed to get rid of japanese keyboard space
      full_query = Word.where("japanese = ?", @query)
      full_query = Word.where("english = ?", @query) if full_query.empty?
      full_query = Word.where("reading = ?", @query) if full_query.empty?
      if full_query.empty?
        @query.gsub!("　", " ")
        @query.split.each do |word|
          full_words = Word.where("japanese = ?", word)
          # Empty checks if the word doesn't exist, nil? doesn't work
          full_words = Word.where("reading = ?", word) if full_words.empty?
          full_words = Word.where("english ILIKE ?", word) if full_words.empty?
          # TODO put error if word doesn't return what is wanted
          # where gives an array, which works as sometimes there are multiple words for a giving aspect
          full_words = Word.where("japanese LIKE ?", "% #{word} %").first(5) if full_words.empty?
          full_words = Word.where("reading LIKE ?", "% #{word} %").first(5) if full_words.empty?
          full_words = Word.where("english ILIKE ?", "% #{word} %").first(5) if full_words.empty?

          @words << full_words unless full_words.empty?

        end
      else
        @words << full_query
      end
    end
  end
end
