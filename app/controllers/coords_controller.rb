require 'open-uri'
require 'json'

class CoordsController < ApplicationController
  def fetch_weather
    # @address = "the corner of Foster and Sheridan"
    @address = params[:address]
    @url_safe_address = URI.encode(@address)

    # Your code goes here.
    url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{@url_safe_address}&sensor=false"
    raw_data = open(url).read
    parsed_data = JSON.parse(raw_data)
    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]
    # @longitude = params[:address]

# get weather
   # @latitude = 42.0538387
   #  @longitude = -87.67721
    your_api_key = "d781af1bc77e2e7e33bfe30e66620a51"

    # Your code goes here.
    url = "https://api.forecast.io/forecast/#{your_api_key}/#{@latitude},#{@longitude}"
    raw_data = open(url).read
    parsed_data = JSON.parse(raw_data)
    @temperature = parsed_data["currently"]["temperature"]
    @minutely_summary = parsed_data["minutely"]["summary"]
    @hourly_summary = parsed_data["hourly"]["summary"]
    @daily_summary = parsed_data["daily"]["summary"]
  end
end
# https://api.forecast.io/forecast/d781af1bc77e2e7e33bfe30e66620a51/37.8267,-122.423
