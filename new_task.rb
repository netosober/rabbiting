require "bunny"

connection = Bunny.new
connection.start

channel = connection.create_channel

queue = channel.queue("task_queue", :durable => true)

message  = ARGV.empty? ? "Hello World!" : ARGV.join(" ")

queue.publish(message, :persistent => true)
puts " [x] Sent #{message}"

connection.close