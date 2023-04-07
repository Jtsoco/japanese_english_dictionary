class ApiController < ApplicationController

  skip_before_action :authenticate_user!

  skip_before_action :verify_authenticity_token, only: :index

  def index
    # params = api_params
    # puts params
    # puts params[:info]
    warden.authenticate!(:api_token)
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
    render json: @words
  end

  private

  # def api_params
  #   params.require(:info).permit(:language, array: [])
  # end
end

# curl request example
# curl -X POST http://localhost:3000/api -H "Content-Type: application/json" -H 'Accept: application/json' -H 'Authorization: Bearer 24bda4cb-c197-4f6a-8e25-720244c2cb8c' -d '{"info": {"language": "japanese", "array": ["食べる"]}}'


# post example
# curl -X POST http://localhost:3000/api -H "Content-Type: application/json" -H 'Accept: application/json' -d '{"info": {"language": "japanese", "array": ["食べる", "飲む"]}}'
# post response
# [[{"id":33490,"japanese":"食べる","english":"to eat","reading":"たべる","created_at":"2023-04-05T02:23:16.012Z","updated_at":"2023-04-05T02:23:16.012Z"}],[{"id":15375,"japanese":"飲む","english":"to drink","reading":"のむ","created_at":"2023-04-05T02:22:50.570Z","updated_at":"2023-04-05T02:22:50.570Z"}]]%

# exmaple of english
# curl -X POST http://localhost:3000/api -H "Content-Type: application/json" -H 'Accept: application/json' -d '{"info": {"language": "english", "array": ["food", "drink"]}}'

# english response
# [[{"japanese":"召し上がりもの","english":"food","reading":"めしあがりもの"},{"japanese":"食べ物","english":"food","reading":"たべもの"},{"japanese":"食品","english":"food","reading":"しょくひん"},{"japanese":"食物","english":"food","reading":"しょくもつ"},{"japanese":"食料","english":"food","reading":"しょくりょう"},{"japanese":"食い物","english":"food","reading":"くいもの"},{"japanese":"食","english":"food","reading":"しょく"},{"japanese":"糧","english":"food","reading":"かて"},{"japanese":"フード","english":"food","reading":"フード"}],[{"japanese":"ドリンク","english":"drink","reading":"ドリンク"},{"japanese":"飲み物","english":"drink","reading":"のみもの"},{"japanese":"飲み","english":"drink","reading":"のみ"}]]
