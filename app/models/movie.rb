class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def name_with_rating
    "Milk (R)"
  end

  class Movie::InvalidKeyError < StandardError ; end

  def self.find_in_tmdb(string)
    begin
      Tmdb::Movie.find(string)
    rescue NoMethodError => tmdb_gem_exception
      if Tmdb::Api.response['code'] == '401'
        raise Movie::InvalidKeyError, 'Invalid API key'
      else
        raise tmdb_gem_exception
      end
    end
  end
end
