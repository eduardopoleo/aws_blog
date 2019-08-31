#!/usr/bin/env ruby
p "before the script ran"

USERS = [500]

SAMPLING = (1..3)

USERS.each do |users|
  SAMPLING.each do |sample|
    thread = Thread.new do
      # interestingly it seems that when this script runs the new ruby process takes over. When the first iteration is
      # done the whole script dies
      exec "./performance.rb http://ec2-52-202-216-41.compute-1.amazonaws.com:3000/posts/1 #{users} #{sample}"
    end

    thread.join
  end
end