# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
require 'csv'
require 'tempfile'
require 'cgi'

set :bind, '0.0.0.0'
set :port, 4567

get '/' do
  erb :index
end

post '/upload' do
  unless params[:file] && (tempfile = params[:file][:tempfile])
    return 'No file uploaded'
  end

  artist_counts = Hash.new(0)
  song_counts = Hash.new(0)
  buffer = ''

  while (chunk = tempfile.read(1024 * 1024))
    buffer += chunk

    buffer.scan(%r{
      <a\ href="https://music\.youtube\.com/watch\?v=[^"]+">([^<]+)</a><br>\s*
      <a\ href="https://www\.youtube\.com/channel/[^"]+">([^<]+)\ -\ Topic</a><br>
    }x) do |song, artist|
      artist_name = CGI.unescapeHTML(artist).sub(/ - Topic$/, '').strip
      song_name = CGI.unescapeHTML(song).strip
      artist_counts[artist_name] += 1
      song_counts[song_name] += 1
    end

    buffer = buffer[-100..] || ''
  end
  @sorted_artists = artist_counts.sort_by { |_artist, count| -count }
  @sorted_songs = song_counts.sort_by { |_song, count| -count }
  erb :results
end
