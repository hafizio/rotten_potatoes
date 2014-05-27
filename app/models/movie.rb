class Movie < ActiveRecord::Base
  def self.all_ratings
    Movie.select(:rating).map(&:rating).uniq
  end
  
  def self.sort_title
    Movie.order(title: :asc)
  end
  
  def self.sort_release_date
    Movie.order(release_date: :asc)
  end
end
