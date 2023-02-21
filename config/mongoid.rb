require "mongoid"

Mongoid.configure do |config|
  config.clients.default = {
    uri: ENV["MONGODB_URI"],
    database: ENV["MONGODB_DATABASE"],
    client_options: { raise_not_found_error: false }
  }
end
