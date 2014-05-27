module MoviesHelper
  def css_class_helper(item)
    params[:sort_by] == item ? 'hilite' : nil
  end
end
