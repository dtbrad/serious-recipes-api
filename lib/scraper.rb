class Scraper
  def self.latest_summaries
    serious_recipe_nodes = get_nodes
    serious_recipe_nodes.map do |node|
      { recipe: { title: node.css(".metadata .title").text,
                  url: node.css(".module__link").attribute("href").value,
                  thumbnail: node.css(".module__image").first.attr("data-src")
                },
        author: { name: node.css(".metadata p").text }
      }
    end
  end

  def self.get_nodes
    serious_recipes_page = open("http://www.seriouseats.com/recipes")
    doc = Nokogiri::HTML(serious_recipes_page)
    doc.css("#posts .module__wrapper")
  end
end
