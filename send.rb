require "bunny"

connection = Bunny.new
connection.start

channel = connection.create_channel

queue = channel.queue('hello')

channel.default_exchange.publish("Hola mundo!", :routing_key => queue.name)

puts " [x] Sent 'Hola mundo!'"

connection.close