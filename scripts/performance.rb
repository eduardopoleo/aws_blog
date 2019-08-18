#!/usr/bin/env ruby

require 'net/http'
require 'json'

url = ARGV[0]
uri = URI(url)

users = ARGV[1].to_i

$requests = 0
$errors = 0
$verb = ARGV[2] || 'get'

def execute_request(verb, uri)
  if verb == 'post'
    Net::HTTP.post(
      uri,
      { 'title' => 'My old little post', 'body' => 'Long little blog post' }.to_json,
      'Content-Type' => 'application/json'
    )
  else
    Net::HTTP.get_response(uri)
  end
end

initial_time = Time.now

for i in 0..users
  Thread.new do
    begin
      while true
        response = execute_request($verb, uri) # => String
        $requests += 1
      end
    rescue StandardError => e
      $errors += 1
      error_pct = ($errors / $requests.to_f) * 100
      time_elapsed = ((Time.now - initial_time) / 60).round(2)

      p "Error(%): #{error_pct}. Total Time: #{time_elapsed} mins"

      retry
    end
  end
end

sleep(300)