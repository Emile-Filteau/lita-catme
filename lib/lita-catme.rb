require "lita"
require 'open-uri'

Lita.load_locales Dir[File.expand_path(
  File.join("..", "..", "locales", "*.yml"), __FILE__
)]

require "lita/handlers/cat"
require "lita/handlers/catme"

Lita::Handlers::Catme.template_root File.expand_path(
  File.join("..", "..", "templates"),
 __FILE__
)
