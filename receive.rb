require "bunny"

connection = Bunny.new
connection.start

channel = connection.create_channel
queue = channel.queue('hello')

puts " [*] Waiting for messages om #{queue.name}. To exit press CTRL+C"
queue.subscribe(:block => true) do |delivery_info, properties, body|
	puts " [x] Received #{body}"

	delivery_info.consumer.cancel
end