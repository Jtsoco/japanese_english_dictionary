# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Word.delete_all
puts "wiping database"
Eiwa.parse_file("lib/assets/JMdict_e.xml", type: :jmdict_e) do |entry|
  word = Word.new
  puts "generating word"
  word.japanese = entry.text
  puts word.japanese
  word.english = entry.meanings.first.definitions.first.text
  puts word.english
  word.reading = entry.readings.first.text
  puts word.reading
  word.save
  puts "word saved!"
end
# # gives us the meaning hash
# entry.meanings.first
# # gives array of all definitions
# entry.meanings.first.definitions
# # gives first of the definitions, there can be more than one, and it gives an instance
# entry.meanings.first.definitions.first
# # gives english characters, .text also works
# entry.meanings.first.definitions.first.characters
# # gives language (english only in this dicitonary?
# entry.meanings.first.definitions.first.language
# # gives a lot of other info
# entry.meanings.first.parent
# # gives japanese reading, furigana
# # entry.meanings.first.parent.readings.first.text
# entry.readings.first.text
# # gives the spelling with kanji might not always have array
# entry.spellings.first.text
# # gets misc tags, like idiomatic expression
# entry.meanings.first.misc_tags.first.text
# # returns an array of things, like if it's a phrase or a noun depending on the .text of the element
# meanings.first.parts_of_speech #.first.text, [1].text or whichever
# # gives the japanese
# entry.text
