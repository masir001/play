class SongsController < ApplicationController
  def show
    @artist = Artist.new(params[:artist_name])
    @song   = @artist.songs.find{|song| song.title == CGI.unescape(params[:title])}
  end

  def search
    @filter = (params[:filter] || :any).to_sym
    @songs = Song.find([@filter,params[:q]])
  end

  def download
    song = Song.new(CGI.unescape(params[:path]))
    send_file(File.join(Play.music_path,song.path), :disposition => 'attachment')
  end
end
