require "bunny"

connection = Bunny.new
connection.start

channel = connection.create_channel
queue = channel.queue("task_queue", :durable => true)

channel.prefetch(1)

puts " [*] Waiting for messages om #{queue.name}. To exit press CTRL+C"

begin
	queue.subscribe(:manual_ack => true, :block => true) do |delivery_info, properties, body|
	  puts " [x] Received #{body}"
	  # imitate some work
	  sleep 5.0
	  puts " [x] Done"

	  channel.ack(delivery_info.delivery_tag)
	end
rescue Interrupt => _
  conn.close
end