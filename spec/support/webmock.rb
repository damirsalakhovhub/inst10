# WebMock configuration for HTTP request mocking
require "webmock/rspec"

WebMock.disable_net_connect!(allow_localhost: true)
