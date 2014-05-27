module MoviesHelper
  def css_helper(item)
    params[:sort_by] == item ? 'hilite' : nil
  end
end
