class WordsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
    @words = []
    if params[:q].present?
      @query = params[:q]
      @query.split.each do |word|
        full_word = Word.where("japanese = ?", word)
        # Empty checks if the word doesn't exist, nil? doesn't work
        full_word = Word.where("reading = ?", word) if full_word.empty?
        full_word = Word.where("english = ?", word) if full_word.empty?
        # TODO put error if word doesn't return what is wanted
        @words << full_word
      end
    end
  end
end
