RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  FactoryBot.definition_file_paths += Dir[Rails.root.join("/spec/support/factories")]
end
