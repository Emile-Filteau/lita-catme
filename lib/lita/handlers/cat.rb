
module Lita
  module Handlers
    class Cat
      BASE_URL = 'http://api.thecatapi.com/api'.freeze
      attr_accessor :url

      class << self
        def fetch(count: nil, category: nil)
          url = "#{BASE_URL}/images/get?format=xml"
          url += "&results_per_page=#{count}" unless count.nil?
          url += "&category=#{category}" unless category.nil?

          Nokogiri::XML(open(url)).css('//url').each_with_object([]) do |cat, cats|
            cats << new(cat.content)
          end
        end

        def fetch_categories
          url = "#{BASE_URL}/categories/list"
          Nokogiri::XML(open(url)).css('//name').each_with_object([]) do |category, categories|
            categories << category.content
          end
        end
      end

      def initialize(url)
        @url = url
      end
    end
  end
end
