# Model to store ratings from users.
class VoterRating
  include MongoMapper::Document
  include RatingsHtml

  belongs_to :politician

  many :votes

  attr_accessible :voter, :rating

  key :rating, Integer
  key :pros, String
  key :cons, String
  key :voter, Boolean, default: false
  key :voted_for, Boolean, default: false
  key :promised, String
  key :achieved, String
  key :user_id, ObjectId

  # For backwards compatibility with records that have no last edit value this is being left out for now.
  #   We might not ever want to re-add it!
  # validates_associated :politician

  validates :rating, numericality: { only_integer: true, greater_than: 0, less_than: 6 },
                     presence: true, length: { maximum: 1 }

  def rating_html
    html = "<table><td valign=center><b class='rating'>" + @rating.to_s + '</b></td><td> ' + rating_hearts_html(@rating, false)
    html += '</td></table>'
    html.html_safe
  end

  def user_display
    user_value('display')
  end

  def user_name
    user_value('name')
  end

  def user_value(field)
    @user = User.find(@user_id)

    if defined?(@user_id) && ! @user.nil?
      if field == 'name'
        return @user.name
      elsif field == 'display'
        return @user.display
      end
    else
      return 'Deleted User'
    end
  end

  def politician_link
    @politician = Politician.find(@politician_id)
    "<a href=/politicians/#{politician_id}>#{@politician.first_name} #{@politician.last_name}</a>"
  end

  def total_votes
    total_not_useful = 0
    votes.each do |vote|
      total_not_useful += 1 unless vote.useful
    end

    votes.count - total_not_useful
  end
end
