
require 'ubr/api'
require 'active_support/all'

module Ubr
  class App

    def self.run!(options)
      new(options).run!
    end

    def initialize(options)
      @options = options
      @client  = API.new
    end

    def run!

      print 'Searching for available Ubers...'
      products = get_available_products
      product = pick_or_choose(products,
        title: 'Available Ubers',
        pick: method(:product_preselected?),
        display: method(:product_description),
      )

      estimate = nil

      loop do
        print 'Getting the ETA...'
        estimate = get_estimate_for(product: product)
        puts
        print_estimate estimate
        break if confirm? "Do you want to request an #{product[:display_name]}?"
        print_separator
      end

      surge_confirmation_id = nil
      if estimate[:surge_confirmation_id] and confirm? "Do you accept the surge?"
        surge_confirmation_id = estimate[:surge_confirmation_id]
      end

      request_uber!(product: product, surge_confirmation_id: surge_confirmation_id)
      puts "Done! Please check your phone."

    end

    def get_available_products
      @client.get('/products', @options[:pickup].to_h)[:products]
    end

    def print_estimate(estimate)
      if estimate[:pickup_estimate]
        puts "Pickup in #{estimate[:pickup_estimate]} minutes."
        puts "Estimation:"

        distance_estimate = estimate[:trip][:distance_estimate]
        distance_unit = estimate[:trip][:distance_unit].pluralize(distance_estimate)
        puts "- Distance: #{distance_estimate} #{distance_unit}"

        pickup_time = estimate[:pickup_estimate].minutes.from_now
        puts "- Pickup #{pickup_time.to_s :time}"

        dropoff_time = pickup_time + estimate[:trip][:duration_estimate].seconds
        puts "- Dropoff #{dropoff_time.to_s :time}"

        surge_x = if estimate[:price][:surge_multiplier] == 1.0
                    'no'
                  else
                    "#{estimate[:price][:surge_multiplier]}"
                  end
        puts "- Price: #{estimate[:price][:display]} (#{surge_x} surge)"
      else
        puts "None available."
      end
    end

    def get_estimate_for(product:)
      @client.post('requests/estimate',
        product_id:      product[:product_id],
        start_latitude:  @options[:pickup].latitude,
        start_longitude: @options[:pickup].longitude,
        end_latitude:    @options[:dropoff].latitude,
        end_longitude:   @options[:dropoff].longitude,
      )
    end

    def request_uber!(product:, surge_confirmation_id:)
      @client.post('requests',
        product_id:      product[:product_id],
        start_latitude:  @options[:pickup].latitude,
        start_longitude: @options[:pickup].longitude,
        end_latitude:    @options[:dropoff].latitude,
        end_longitude:   @options[:dropoff].longitude,
        surge_confirmation_id: surge_confirmation_id,
      )
    end

    private

    def product_preselected?(product)
      @options[:product] and product[:display_name].casecmp(@options[:product]).zero?
    end

    def product_description(product)
      "#{product[:display_name]}"
    end

    def pick_or_choose(items, pick:, display:, title:)
      puts
      begin
        items.find(&pick) or begin
          puts "#{title}:"
          items.each_with_index do |item, index|
            puts "- #{index + 1}. #{display[item]}"
          end
          puts
          print "Your choice: "
          items[$stdin.gets.to_i - 1] or raise "Invalid item."
        end
      end.tap do |item|
        puts "Selected: #{display[item]}"
      end
    end

    def print_separator
      puts "=" * 64
    end

    def confirm?(message)
      print message
      print " (y to confirm): "
      $stdin.gets.strip.casecmp('y').zero?
    end

  end
end
