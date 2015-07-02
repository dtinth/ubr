
require 'optparse'
require 'launchy'
require 'ubr/coordinate'
require 'ubr/api'

module Ubr
  class CLI
    def self.parse_options!

      options = {}
      argv = ARGV.dup

      OptionParser.new do |opts|

        opts.banner = 'Usage: ubr <pickup> <dropoff> [options]'
        opts.separator ''
        opts.separator 'ubr: Request an Uber from the command line.'
        opts.separator ''
        opts.separator 'Options:'

        opts.on('-h', '--help', 'Displays this help') do
          puts opts
          exit
        end

        opts.on('-p', '--product NAME', 'Automatically selects a product') do |product|
          options[:product] = product
        end

      end.parse!(argv)

      case argv[0]
      when 'login'
        client_id = argv[1] or raise "Client ID needed"
        login!(client_id)
        exit
      when 'authorize'
        client_id = argv[1] or raise "Client ID needed"
        code = argv[2] or raise "Code needed"
        redirect_uri = argv[3] or raise "Redirect URI needed"
        authorize!(client_id, code, redirect_uri)
        exit
      end

      options[:pickup]  = Coordinate.parse(argv.shift) or raise "Pickup location needed!"
      options[:dropoff] = Coordinate.parse(argv.shift) or raise "Dropoff location needed!"

      raise "Unrecognized args: #{argv.inspect}" unless argv.empty?

      options

    end

    def self.login!(client_id)
      uri = 'https://login.uber.com/oauth/authorize?' + [
        'response_type=code',
        'client_id=' + client_id,
        'state=' + client_id,
        'scope=request',
      ].join('&')
      puts "Opening login URL: #{uri}"
      Launchy.open(uri)
    end

    def self.authorize!(client_id, code, redirect_uri, secret=nil)
      unless secret
        print "Give me your secret: "
        secret = $stdin.gets.strip
      end
      result = API.authorize(client_id: client_id, code: code, secret: secret, redirect_uri: redirect_uri)
      p result
    end

  end
end
