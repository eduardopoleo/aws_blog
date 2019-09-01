#!/usr/bin/env ruby

require 'net/http'
require 'json'

uri = URI(ARGV[0])
users = ARGV[1].to_i
sample = ARGV[2]

requests = 0
errors = 0
initial_time = Time.now
file_name = "#{users}-#{sample}"
out_file = File.new(file_name, "w")

p "Collecting info for #{file_name}"

for i in 0..users
  Thread.new do
    begin
      while true
        Net::HTTP.post(
          uri,
          { 'title' => 'My old little post', 'body' => 'Long little blog post' }.to_json,
          'Content-Type' => 'application/json'
        ) # => String
        requests += 1
      end
    rescue StandardError => e
      errors += 1
      error_pct = (errors / requests.to_f) * 100
      time_elapsed = ((Time.now - initial_time) / 60).round(2)

      p "#{error_pct}, #{time_elapsed}"
      out_file.puts("#{error_pct}, #{time_elapsed}")

      retry
    end
  end
end

sleep(300)

out_file.puts("requests, #{requests}")
out_file.puts("errors, #{errors}")
out_file.close
system('say "You are done"')

# curl -d '{"title":"My old little post", "body":"Long little blog post"}'\ -H "Content-Type: application/json" -X POST http://ec2-54-226-196-160.compute-1.amazonaws.com:3000/posts