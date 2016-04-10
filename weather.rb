require "open_weather"

def parseWeather(city)
  r = OpenWeather::Current.city(city, {APPID: APPID})
  return "Please tell me the city name." if r["weather"].nil?
  wcc = r["weather"][0]["id"].to_i
  if 200 <= wcc && wcc < 300    # Group 2XX - Thunderstorm
    emoji = "\u1F329"
  elsif 300 <= wcc && wcc < 400 # Group 3XX - Drizzle
    emoji = "\u1F327"
  elsif 500 <= wcc && wcc < 600 # Group 5XX - Rain
    emoji = "\u1F326" if wcc <= 510
    emoji = "\u1F327" if wcc == 511 # Snow
    emoji = "\u1F327" if wcc >= 512
  elsif 600 <= wcc && wcc < 700 # Group 6XX - Snow
    emoji = "\u1F328"
  elsif 700 <= wcc && wcc < 800 # Group 7XX - Atmosphere
    emoji = "\u1F32A"
  elsif wcc == 800              # Group 800 - Clear
    emoji = "\u2600"
  elsif 801 <= wcc && wcc < 900 # Group 8XX - Clouds
    emoji = "\u26C5" if wcc == 801
    emoji = "\u1F325" if wcc == 802
    emoji = "\u2601" if wcc >= 803
  elsif 900 <= wcc && wcc < 910 # Group 90X - Extreme
    emoji = "\u1F32A" if wcc <= 902
    emoji = "\u2600" if wcc == 903
    emoji = "\u2744" if wcc == 904
    emoji = "\u1F32A" if wcc == 905
    emoji = "\u1F32B" if wcc == 906
  elsif 910 <= wcc              # Group 9XX - Additional 
    emoji = "Sorry, we can not response weather by emoji."
  end
  emoji  
end
