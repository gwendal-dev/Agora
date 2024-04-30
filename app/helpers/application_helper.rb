module ApplicationHelper
    def youtube_embed(content)
      youtube_url_regex = /(?:https?:\/\/)?(?:www\.)?(youtube\.com\/watch\?v=|youtu\.be\/)([a-zA-Z0-9_-]{11})/
      content.gsub(youtube_url_regex) do |url|
        video_id = URI.parse(url).query.split('v=').last.split('&').first rescue url.split('/').last
        <<-HTML.squish.html_safe
          <iframe width="560" height="315" src="https://www.youtube.com/embed/#{video_id}" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
        HTML
      end.html_safe
    end
  end
  