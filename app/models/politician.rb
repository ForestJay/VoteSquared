# Model for storing politicians.
class Politician
  include MongoMapper::Document
  include RatingsHtml

  many :voter_ratings
  many :watches

  # New fields need to be added to the controller, the form, and here.

  key :first_name, String
  key :last_name, String
  key :country, String
  key :state, String
  key :current_office, String
  key :candidate_for, String
  key :last_edit_user_id, ObjectId
  key :city, String
  key :county, String
  key :wikipedia_link, String
  key :campaign_link, String
  key :open_secrets_link, String
  key :official_link, String
  key :facebook, String
  key :google, String
  key :twitter, String

  validates :first_name, presence: true,
                         length: { minimum: 2 }
  validates :last_name, presence: true,
                        length: { minimum: 2 }
  validates :country, presence: true

  validates :last_edit_user_id, presence: true,
                                length: { minimum: 2 }
  validates :city, presence: true, if: :town_or_city_office?
  validates :county, presence: true, if: :county_office?

  def town_or_city_office?
    if is_office?('city')
      return true
    elsif is_office?('town')
      return true
    end

    false
  end

  def county_office?
    if is_office?('county')
      return true
    end

    false
  end

  def is_office?(office)
    if @current_office.length == 0
    elsif OFFICES[COUNTRY][@current_office]['level'] == office
      return true
    end

    if @candidate_for.length == 0
    elsif OFFICES[COUNTRY][@candidate_for]['level'] == office
      return true
    end

    false
  end

  def last_edit_user
    @user = User.find(@last_edit_user_id)
    if @user.nil?
      return ' '
    elsif defined?(@user)
      return @user.display
    else
      return ' '
    end
  end

  def has_social_links?
    if !defined?(@google)
      return false
    elsif !defined?(@facebook)
      return false
    elsif !defined?(@twitter)
      return false
    elsif @google.empty? && @facebook.empty? && @twitter.empty?
      return false
    end
    true
  end

  def sort_value
    if voter_ratings.none?
      return 0
    end

    avg = rating_avg
    avg * 100 + voter_ratings.count
  end

  def rating_avg
    if voter_ratings.none?
      return 0
    end

    total = 0

    voter_ratings.each do |voter_rating|
      total += voter_rating.rating
    end

    total.to_f / voter_ratings.count
  end

  def rating_stats_html
    if voter_ratings.none?
      return '0 ratings'
    end

    avg = rating_avg

    fraction = avg.to_f - avg.to_i

    if fraction > 0.25 && fraction < 0.75
      half = true
    else
      half = false
    end

    if fraction > 0.75
      avg += 1
    end

    str = rating_hearts_html(avg, half)
    str += ' ' + voter_ratings.count.to_s
    str += ' ' + 'rating'.pluralize(voter_ratings.count)

    str.html_safe
  end

  def full_name
    first_name + ' ' + last_name
  end

  def already_watching?(politician, user_id)
    politician.watches.each do |watch|
      if watch.watcher_id == user_id
        return watch
      end
    end
    false
  end
end
