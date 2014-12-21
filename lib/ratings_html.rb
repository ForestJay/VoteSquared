module RatingsHtml
 
  def rating_hearts_html(rating,half)
    str = " "
    (1..5).each do |i|
      if rating.to_i >= i
        str += "<img src=/Heart.png>"
      elsif half
        str += "<img src=/HalfHeart.png>"
        half = false
      else
        str += "<img src=/EmptyHeart.png>"
      end
    end
    puts str
    return str
  end
end