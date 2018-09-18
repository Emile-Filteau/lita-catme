module Lita
  module Handlers
    class Catme < Handler
      route(/^cat( me)?$/i, :cat_me, command: true, help: { 'cat me' => t('help.cat_me') })
      route(/^cat bomb( (\d+))?$/i, :cat_bomb, command: true, help: { 'cat bomb N' => t('help.cat_bomb') })
      route(/^cat categories$/i, :cat_categories, command: true, help: { 'cat categories' => t('help.cat_categories') })
      route(/^cat( me)? (with|in)( (\w+))?$/i, :cat_with_category, command: true, help: { 'cat (with|in) category' => t('help.cat_with_category') })

      def cat_me(response)
        response.reply(Cat.fetch.first.url)
      end

      def cat_bomb(response)
        count = (response.args[1] || 5).to_i
        count = 20 if count > 20

        Cat.fetch(count: count).each { |cat| response.reply(cat.url) }
      end

      def cat_categories(response)
        Cat.fetch_categories.each { |category| response.reply(category) }
      end

      def cat_with_category(response)
        if cat = Cat.fetch(category: response.args[1]).first
          response.reply(cat.url)
        else
          response.reply(t('cat_with_category.unrecognized_category'))
        end
      end

      Lita.register_handler(self)
    end
  end
end
