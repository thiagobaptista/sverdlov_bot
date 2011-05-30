# -*- coding: utf-8 -*-

require "rubygems"
require "twitter"

CONSUMER_KEY = "insert your consumer key here"
CONSUMER_SECRET = "insert your consumer secret here"
OAUTH_TOKEN = "insert your oauth token here"
OAUTH_TOKEN_SECRET = "insert your oauth token secret here"

FAKES = ["@amanda_gurgel_"]

YOUR_ACCOUNT = "thiagobaptista"

Twitter.configure do |config|

  config.consumer_key = CONSUMER_KEY
  config.consumer_secret = CONSUMER_SECRET
  config.oauth_token = OAUTH_TOKEN
  config.oauth_token_secret = OAUTH_TOKEN_SECRET
  
end 


class SverdlovBot
  
    def initialze
    
        @last_update_timestamp = Time.now
    
    end
    
    def update_example
    
        client = Twitter::Client.new

        client.update("Starting sverdlov_bot for a bolshevik \"search and destroy\" of fakes!")
    
    end
    
    def search(string)
    
        busca = Twitter::Search.new
        client = Twitter::Client.new

        busca.containing(string).per_page(100).each do |r|
            
            time = get_time_from r.created_at
            
            if time.to_i > @last_update_timestamp.to_i and r.from_user != YOUR_ACCOUNT
                
                puts "Tweet found: #{r.created_at} - #{r.from_user}: #{r.text}"
                
                begin
                
                    client.update("Atenção, @#{r.from_user}, o perfil @amanda_gurgel_ é FALSO! O perfil verdadeiro da prof. Amanda Gurgel é @amandagurgel930.")
                    
                rescue
                
                    puts "Deu zebra..."
                
                end
                
            end
            
        end
    
    end
    
    def watch_for_fakes
    
        i = 0
        
        while true       
            
            puts @last_update_timestamp
        
            FAKES.each do |fake|
            
                search fake
            
            end
            
            puts "\n"
            
            i = i + 1
            
            sleep(15)
              
            @last_update_timestamp = Time.now
        
        end    
    
    end
    
    private
        def get_time_from(string)
        
            data = string.split
            tempo = data[4].split(':')
            
            time = Time.new(data[3], data[2], data[1], tempo[0].to_i, tempo[1].to_i, tempo[2].to_i)
        
        end

end

bot = SverdlovBot.new

bot.watch_for_fakes

