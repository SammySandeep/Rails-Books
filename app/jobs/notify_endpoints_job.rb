class NotifyEndpointsJob < ApplicationJob
  require 'json'
  require 'httparty'
  require 'jwt'
  
  queue_as :default

  def perform(book)
    endpoints = ENV['THIRD_PARTY_API_ENDPOINTS']
        
        if endpoints.present?
            Rails.configuration.x.third_party_api_endpoints = endpoints.split(',')
          else
            Rails.configuration.x.third_party_api_endpoints = []
        end
        
        payload = {
            title: book.title,
            author: book.author,
            published_year: book.published_year
            }
         
        jwt_secret = ENV['jwt_secret']
        token = JWT.encode(payload, jwt_secret, 'HS256')   
        
        headers = {
            "Authorization" => "Bearer #{token}",
            "Content-Type" => "application/json"
            }
  
        Rails.configuration.x.third_party_api_endpoints.each do |endpoint_url|
            response = HTTParty.post(endpoint_url, 
            body: payload.to_json, 
            headers: headers
        ) 
  
          if response.code == "200"
            Rails.logger.info "Successfully notified #{endpoint_url} for Book #{book.id}."
          else
            Rails.logger.error "Failed to notify #{endpoint_url} for Book #{book.id}. Response: #{response.body}"
          end          
    
        end
      end
end
