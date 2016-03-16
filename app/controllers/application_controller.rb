class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method [:markdown]

  # Redcarpet  
  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      sha = Digest::SHA1.hexdigest(code)
      Rails.cache.fetch ["code", language, sha].join("-") do
        Pygments.highlight(code, :lexer => language)
      end
    end
  end

  protected

  # pygments.rb
  def markdown(text)
    renderer = HTMLwithPygments.new({
      :filter_html => true,
      :hard_wrap => true,
      :link_attributes => {:rel => 'external nofollow'}
    })

    options = {
      :autolink => true,
      :no_intra_emphasis => true,
      :fenced_code_blocks => true,
      :lax_html_blocks => true,
      :strikethrough => true,
      :superscript => true
    }

    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end
  
end
