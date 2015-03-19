module RatingsHtml
 
  def rating_hearts_html(rating,half)
    str = " "
    (1..5).each do |i|
      if rating.to_i >= i
        str += "<img src=http://votesquared.org/Heart.png>"
      elsif half
        str += "<img src=http://votesquared.org/HalfHeart.png>"
        half = false
      else
        str += "<img src=http://votesquared.org/EmptyHeart.png>"
      end
    end
    puts str
    return str
  end
end