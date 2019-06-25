class Song < ApplicationRecord
  validates :title, presence: :true, uniqueness: { scope: :artist_name}, uniqueness: {scope: :release_year}
  validates :artist_name, presence: :true
  validate :is_true_release
  validate :future_release_year

  def is_true_release
    if released && release_year.blank?
      errors.add(:is_true_release, "The year cannot be blank if released==true")
    end
  end 

  def future_release_year
    if release_year.present? && release_year > Date.today.year
      errors.add(:future_release_year, "The release year cannot be in the future")
    end
  end
end
