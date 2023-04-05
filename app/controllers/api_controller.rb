class ApiController < ApplicationController

  skip_before_action :authenticate_user!

  skip_before_action :verify_authenticity_token, only: :index

  def index
    params = api_params
    # puts params
    # puts params[:info]
    @words = []
    if params[:language] == "japanese"
      params[:array].each do |word|
        full_words = Word.where("japanese = ?", word)
        full_words = Word.where("reading = ?", word) if full_words.empty?
        @words << full_words unless full_words.empty?
      end
    elsif params[:language] == 'english'
      params[:array].each do |word|
        full_words = Word.where("english ILIKE ?", word)
        @words << full_words unless full_words.empty?
      end
    end
    # @words << params[:info][:array].first
    # @words = Word.where('japanese = ?', '食べる')
    @word_list = @words.map do |word_set|
      word_set.map do |word|
        {
          japanese: word.japanese,
          english: word.english,
          reading: word.reading
        }
      end
    end
    render json: @word_list
  end

  private

  def api_params
    params.require(:info).permit(:language, array: [])
  end
end

# curl request example
# curl -X POST http://localhost:3000/api -H "Content-Type: application/json" -H 'Accept: application/json' -d '{"info": {"language": "japanese", "array": ["食べる"]}}'
