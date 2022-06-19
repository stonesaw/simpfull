require 'webrick'
require 'launchy'

srv = WEBrick::HTTPServer.new({ :DocumentRoot => './',
                                :BindAddress => '127.0.0.1',
                                :Port => 20080
                              })

srv.mount('/', WEBrick::HTTPServlet::FileHandler, 'public/index.html', { :FancyIndexing => false })

trap("INT") {
  srv.shutdown
}

puts "see \"http://localhost:20080\""
Launchy.open("http://localhost:20080")

srv.start
