module Lita
  module Handlers
    class Cat
      BASE_URL = 'http://api.thecatapi.com/v1'.freeze
      CATEGORIES = {
        hats: 1,
        space: 2,
        funny: 3,
        sunglasses: 4,
        boxes: 5,
        caturday: 6,
        ties: 7,
        dream: 9,
        kittens: 10,
        sinks: 14,
        clothes: 15,
      }

      attr_accessor :url

      class << self
        def fetch(count: nil, category: nil)
          url = "#{BASE_URL}/images/search?format=json"
          url += "&limit=#{count}" unless count.nil?
          if category.present?
            return [] unless valid_category?(category)
            url += "&category_ids=#{CATEGORIES[category.to_sym]}"
          end

          JSON.parse(open(url) { |io| io.read }).each_with_object([]) do |cat, cats|
            cats << new(cat["url"])
          end
        end

        def fetch_categories
          CATEGORIES.keys.map(&:to_s)
        end

        private

        def valid_category?(category)
          fetch_categories.include?(category)
        end
      end

      def initialize(url)
        @url = url
      end
    end
  end
end
