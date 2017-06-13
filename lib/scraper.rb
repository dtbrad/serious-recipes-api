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

  def self.get_full_recipe(recipe_url)
    recipe_detail = {}
    recipe_page = open(recipe_url)
    doc = Nokogiri::HTML(recipe_page)
    recipe_detail[:recipe_ingredients] = doc.css(".ingredient").collect {|i| i.text}
    recipe_detail[:recipe_description] = doc.css("#entry-text .recipe-introduction-body p").text.split("]")[1]
    recipe_detail[:recipe_directions] = doc.css(".recipe-procedure-text p").collect {|step| step.text}.select{|s| !s.empty? }
    recipe_detail[:recipe_image] = doc.css(".photo").attr("src").value
    recipe_detail
  end
end
