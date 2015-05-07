class ActiveAdmin::Views::Pages::Base < Arbre::HTML::Document

  private

  # Renders the content for the footer
  def build_footer
    div :id => "footer" do
      para "Powered by #{link_to('Agile Creative Consulting', 'http://www.google.com')} ".html_safe
    end
  end

end