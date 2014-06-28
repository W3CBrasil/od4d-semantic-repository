require "article"

describe Article do

  context "given an article" do

    article = Article.new("http://the/link")
    article.title = "the title"
    article.description = "The site of the/link"
    article.language = "en-US"
    article.author = "Yasodara Cordova"
    article.datePublished  = "10/07/2031"
    article.articleBody = "Un conteudo mucho louco"
    article.articleSection = "sports"

    context "when it is converted to a resource" do

      resource = article.to_resource

      it "the resource should have an uri" do
        expect(resource.uri).to eq("http://the/link")
      end

      it "the resource should have a type" do
        expect(resource.type).to eq("Article")
      end

      it "the resource should have the property headline" do
        expect(resource.properties["headline"]).to eq("the title")
      end

      it "the resource should have the property url" do
        expect(resource.properties["url"]).to eq("http://the/link")
      end

      it "the resource should have the property description" do
        expect(resource.properties["description"]).to eq("The site of the/link")
      end

      it "the resource should have the property inLanguage" do
        expect(resource.properties["inLanguage"]).to eq("en-US")
      end

      it "the resource should have the property author" do
        expect(resource.properties["author"]).to eq("Yasodara Cordova")
      end

      it "the resource should have the property datePublished" do
        expect(resource.properties["datePublished"]).to eq("10/07/2031")
      end

      it "the resource should have the property articleBody" do
        expect(resource.properties["articleBody"]).to eq("Un conteudo mucho louco")
      end

      it "the resource should have the property articleSection" do
        expect(resource.properties["articleSection"]).to eq("sports")
      end

    end

  end

end
