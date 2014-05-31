module MoviesHelper
  def oddness(count)
    count.odd? ? 'odd' : 'even'
  end
  
  def highlight(sort_by)
    'hilite' if @sorted_by == sort_by
  end
  
  def rating_selected(rating)
    @selected_ratings.include?(rating)
  end
end
