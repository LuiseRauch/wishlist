module ApplicationHelper
  def form_group_tag(errors, &block)
    css_class = 'form-group'
    css_class << ' has-error' if errors.any?
    content_tag :div, capture(&block), class: css_class
  end


  def num_stars(score)
      full_star = score.to_i

      num_stars = { :full => 0, :empty => 0 }

      num_stars[:full]  = full_star
      num_stars[:empty] = 5 - (full_star)

      num_stars
  end
end
