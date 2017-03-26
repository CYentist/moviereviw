class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :films
  has_many :reviews
  has_many :film_relationships
  has_many :favored_films, :through => :film_relationships, :source => :film

  def is_favored?(film)
    favored_films.include?(film)
  end

  def favor!(film)
    favored_films << film
  end

  def dislike!(film)
    favored_films.delete(film)
  end
end
