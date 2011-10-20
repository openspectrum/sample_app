module ApplicationHelper

  # Return a title on a per-page basis.
  def title
    base_title = "Ruby on Rails Tutorial Sample App"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  # Load the logo image
  def logo
    image_tag("http://railstutorial.org/images/sample_app/logo.png", :alt => "Sample App", :class => "round" )
  end
  
end
