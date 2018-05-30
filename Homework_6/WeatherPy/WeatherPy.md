
# Analysis

For this exercise, I took a random sample of 500 cities across the globe, specifically between -90 and 90 degrees latitude to look for data to answer the question "What's the weather like as we approach the equator?"

I got my list of cities by randomly picking a latitude between -90 and 90 degrees and a longitude between -180 and 180 degrees and using the "citipy" library to find the nearest city to those coordinates.  Once the city was found, I used the OpenWeatherMap API to find the weather. If the weather data doesn't exist, the city is discarded and the script looks for another set of coordinates until it collects 500. 

The first thing I noticed was that regardless of how many times I run the script, the data points fall between -60 and 80 degrees longitude even though the random function is set between -90 and 90. It makes sense once you look at a map and notice that the only thing south of 60 degrees latitude is the Antartic Circle and north of 80 degrees is the Artic Circle, so although coordinates may have come up for those areas, it is highly unlikely that weather data was available and therefore, not in the data set. For this exercise, gathering additional data for this part of the world wouldn't alter the trend the current data is displaying, so I didn't investigate further.

The assumption is that the weather gets warmer and more humid the closer one gets to the equator.  The first graph, City Latitude vs. Max Temperature supports that assumption, with the highest temperatures occurring within 20 degrees latitude north or south from the equator and the temperatures continue declining as you move away from the equator. The second graph, City Latitude vs. Humidity does not support my assumption of being more humid the closer one gets to the equator. Where the highest temperatres are seen, between -20 and 20 degrees latitude, the humidity ranges from 20% to 100% and at the edges, -40 and 80 degrees latitude, there are cities with humidity between 80% and 100%. One might think it is more humid closer to the equator because the temperature is higher making it miserable, but it does seem that humidity is not affected by the proximity to the equator. 

I don't know much about the weather, but I didn't expect cloudiness or wind speed to be a useful descriptor of the weather near the equator, and they turned out not to be. Significant weather patterns used to describe the equator usually only include heat and humidity. As with humidity, the chartd City Latitude vs. Cloudiness and City Latitude vs. Wind Speed, show that there is no significant trend of either at the equator. What was expected was that the Cloudiness and Humidity charts to corrolate more than they seem to. 


```python
from citipy import citipy
from config import api_key
import openweathermapy.core as owm
import requests
import random
import pandas as pd
import matplotlib.pyplot as plt
```

# Generate Cities List and Make API Calls


```python
cities = []
countries = []
date = []
latitude = []
max_temp = []
humidity = []
clouds = []
wind_speed = []
counter = 1
url = "http://api.openweathermap.org/data/2.5/weather?"
units = "imperial"
records = 500

print("Beginning Data Retrieval")
print("------------------------------")
while counter <= records:
    lat = random.randint(-90,90)
    long = random.randint(-180,180)    
    city_data = citipy.nearest_city(lat, long)
    city = city_data.city_name
    country = city_data.country_code
    
    if not city in cities:
        try: 
            query_url = f"{url}appid={api_key}&units={units}&q={city}"
            weather_data = requests.get(query_url).json()
            cities.append(city) 
            countries.append(country)
            date.append(weather_data["dt"])
            latitude.append(weather_data["coord"]["lat"])
            max_temp.append(weather_data["main"]["temp_max"])
            humidity.append(weather_data["main"]["humidity"])
            clouds.append(weather_data["clouds"]["all"])
            wind_speed.append(weather_data["wind"]["speed"])
            print(f"Processing Record {counter} of {records} | {city}")
            print(f"{query_url}")
            counter += 1
        except:
            cities.remove(city)
            countries.remove(country)
print("------------------------------")
print("Data Retrieval Complete")
print("------------------------------")

```

    Beginning Data Retrieval
    ------------------------------
    Processing Record 1 of 500 | saint-philippe
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=saint-philippe
    Processing Record 2 of 500 | plast
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=plast
    Processing Record 3 of 500 | rikitea
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=rikitea
    Processing Record 4 of 500 | albany
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=albany
    Processing Record 5 of 500 | amberley
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=amberley
    Processing Record 6 of 500 | muroto
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=muroto
    Processing Record 7 of 500 | iquitos
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=iquitos
    Processing Record 8 of 500 | jadu
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=jadu
    Processing Record 9 of 500 | jamestown
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=jamestown
    Processing Record 10 of 500 | north bend
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=north bend
    Processing Record 11 of 500 | namibe
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=namibe
    Processing Record 12 of 500 | ambilobe
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=ambilobe
    Processing Record 13 of 500 | nikolskoye
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=nikolskoye
    Processing Record 14 of 500 | ribeira grande
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=ribeira grande
    Processing Record 15 of 500 | atuona
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=atuona
    Processing Record 16 of 500 | barrow
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=barrow
    Processing Record 17 of 500 | khatanga
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=khatanga
    Processing Record 18 of 500 | mataura
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=mataura
    Processing Record 19 of 500 | bredasdorp
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=bredasdorp
    Processing Record 20 of 500 | ushuaia
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=ushuaia
    Processing Record 21 of 500 | hofn
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=hofn
    Processing Record 22 of 500 | katangli
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=katangli
    Processing Record 23 of 500 | tuatapere
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=tuatapere
    Processing Record 24 of 500 | bluff
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=bluff
    Processing Record 25 of 500 | punta arenas
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=punta arenas
    Processing Record 26 of 500 | iqaluit
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=iqaluit
    Processing Record 27 of 500 | hermanus
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=hermanus
    Processing Record 28 of 500 | bilibino
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=bilibino
    Processing Record 29 of 500 | areia branca
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=areia branca
    Processing Record 30 of 500 | lompoc
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=lompoc
    Processing Record 31 of 500 | longyearbyen
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=longyearbyen
    Processing Record 32 of 500 | aquiraz
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=aquiraz
    Processing Record 33 of 500 | kapaa
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=kapaa
    Processing Record 34 of 500 | buraydah
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=buraydah
    Processing Record 35 of 500 | buala
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=buala
    Processing Record 36 of 500 | aktau
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=aktau
    Processing Record 37 of 500 | thompson
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=thompson
    Processing Record 38 of 500 | algodones
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=algodones
    Processing Record 39 of 500 | tasiilaq
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=tasiilaq
    Processing Record 40 of 500 | springbok
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=springbok
    Processing Record 41 of 500 | ola
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=ola
    Processing Record 42 of 500 | vaini
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=vaini
    Processing Record 43 of 500 | kaitangata
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=kaitangata
    Processing Record 44 of 500 | kruisfontein
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=kruisfontein
    Processing Record 45 of 500 | cayenne
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=cayenne
    Processing Record 46 of 500 | brae
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=brae
    Processing Record 47 of 500 | georgetown
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=georgetown
    Processing Record 48 of 500 | grindavik
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=grindavik
    Processing Record 49 of 500 | hilo
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=hilo
    Processing Record 50 of 500 | busselton
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=busselton
    Processing Record 51 of 500 | tuktoyaktuk
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=tuktoyaktuk
    Processing Record 52 of 500 | lorengau
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=lorengau
    Processing Record 53 of 500 | cedar city
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=cedar city
    Processing Record 54 of 500 | san andres
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=san andres
    Processing Record 55 of 500 | vredendal
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=vredendal
    Processing Record 56 of 500 | port alfred
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=port alfred
    Processing Record 57 of 500 | hirara
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=hirara
    Processing Record 58 of 500 | pisco
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=pisco
    Processing Record 59 of 500 | tonstad
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=tonstad
    Processing Record 60 of 500 | seoul
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=seoul
    Processing Record 61 of 500 | hobart
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=hobart
    Processing Record 62 of 500 | puerto ayora
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=puerto ayora
    Processing Record 63 of 500 | hithadhoo
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=hithadhoo
    Processing Record 64 of 500 | arraial do cabo
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=arraial do cabo
    Processing Record 65 of 500 | palana
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=palana
    Processing Record 66 of 500 | sao filipe
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=sao filipe
    Processing Record 67 of 500 | belaya kholunitsa
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=belaya kholunitsa
    Processing Record 68 of 500 | bambous virieux
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=bambous virieux
    Processing Record 69 of 500 | santa fe
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=santa fe
    Processing Record 70 of 500 | imphal
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=imphal
    Processing Record 71 of 500 | new norfolk
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=new norfolk
    Processing Record 72 of 500 | ostrovnoy
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=ostrovnoy
    Processing Record 73 of 500 | colares
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=colares
    Processing Record 74 of 500 | mahebourg
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=mahebourg
    Processing Record 75 of 500 | esperance
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=esperance
    Processing Record 76 of 500 | drayton valley
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=drayton valley
    Processing Record 77 of 500 | gwadar
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=gwadar
    Processing Record 78 of 500 | lebu
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=lebu
    Processing Record 79 of 500 | beidao
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=beidao
    Processing Record 80 of 500 | atar
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=atar
    Processing Record 81 of 500 | cape town
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=cape town
    Processing Record 82 of 500 | thyolo
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=thyolo
    Processing Record 83 of 500 | ariquemes
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=ariquemes
    Processing Record 84 of 500 | murgab
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=murgab
    Processing Record 85 of 500 | trelew
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=trelew
    Processing Record 86 of 500 | baneh
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=baneh
    Processing Record 87 of 500 | baoqing
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=baoqing
    Processing Record 88 of 500 | lasa
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=lasa
    Processing Record 89 of 500 | ambon
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=ambon
    Processing Record 90 of 500 | geraldton
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=geraldton
    Processing Record 91 of 500 | chokurdakh
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=chokurdakh
    Processing Record 92 of 500 | anaconda
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=anaconda
    Processing Record 93 of 500 | chumikan
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=chumikan
    Processing Record 94 of 500 | avarua
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=avarua
    Processing Record 95 of 500 | kreuztal
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=kreuztal
    Processing Record 96 of 500 | koster
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=koster
    Processing Record 97 of 500 | saint-francois
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=saint-francois
    Processing Record 98 of 500 | solwezi
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=solwezi
    Processing Record 99 of 500 | filingue
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=filingue
    Processing Record 100 of 500 | lerici
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=lerici
    Processing Record 101 of 500 | sur
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=sur
    Processing Record 102 of 500 | qaanaaq
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=qaanaaq
    Processing Record 103 of 500 | laguna
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=laguna
    Processing Record 104 of 500 | oktyabrskoye
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=oktyabrskoye
    Processing Record 105 of 500 | amapa
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=amapa
    Processing Record 106 of 500 | ilinskiy
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=ilinskiy
    Processing Record 107 of 500 | thinadhoo
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=thinadhoo
    Processing Record 108 of 500 | lubango
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=lubango
    Processing Record 109 of 500 | pacific grove
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=pacific grove
    Processing Record 110 of 500 | kodiak
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=kodiak
    Processing Record 111 of 500 | chuy
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=chuy
    Processing Record 112 of 500 | yar-sale
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=yar-sale
    Processing Record 113 of 500 | guerrero negro
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=guerrero negro
    Processing Record 114 of 500 | leningradskiy
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=leningradskiy
    Processing Record 115 of 500 | bulungu
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=bulungu
    Processing Record 116 of 500 | mtwara
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=mtwara
    Processing Record 117 of 500 | varkkallai
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=varkkallai
    Processing Record 118 of 500 | samarai
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=samarai
    Processing Record 119 of 500 | avera
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=avera
    Processing Record 120 of 500 | pochutla
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=pochutla
    Processing Record 121 of 500 | saint george
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=saint george
    Processing Record 122 of 500 | haines junction
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=haines junction
    Processing Record 123 of 500 | marsa matruh
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=marsa matruh
    Processing Record 124 of 500 | provideniya
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=provideniya
    Processing Record 125 of 500 | kavieng
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=kavieng
    Processing Record 126 of 500 | tingi
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=tingi
    Processing Record 127 of 500 | munai
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=munai
    Processing Record 128 of 500 | nanortalik
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=nanortalik
    Processing Record 129 of 500 | yumen
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=yumen
    Processing Record 130 of 500 | mahajanga
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=mahajanga
    Processing Record 131 of 500 | tiksi
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=tiksi
    Processing Record 132 of 500 | doha
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=doha
    Processing Record 133 of 500 | tura
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=tura
    Processing Record 134 of 500 | yatou
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=yatou
    Processing Record 135 of 500 | lavrentiya
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=lavrentiya
    Processing Record 136 of 500 | muros
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=muros
    Processing Record 137 of 500 | te anau
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=te anau
    Processing Record 138 of 500 | saskylakh
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=saskylakh
    Processing Record 139 of 500 | bontang
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=bontang
    Processing Record 140 of 500 | makakilo city
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=makakilo city
    Processing Record 141 of 500 | upernavik
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=upernavik
    Processing Record 142 of 500 | kysyl-syr
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=kysyl-syr
    Processing Record 143 of 500 | cabo san lucas
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=cabo san lucas
    Processing Record 144 of 500 | east london
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=east london
    Processing Record 145 of 500 | watertown
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=watertown
    Processing Record 146 of 500 | akureyri
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=akureyri
    Processing Record 147 of 500 | cherskiy
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=cherskiy
    Processing Record 148 of 500 | isangel
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=isangel
    Processing Record 149 of 500 | norman wells
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=norman wells
    Processing Record 150 of 500 | prince albert
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=prince albert
    Processing Record 151 of 500 | batagay-alyta
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=batagay-alyta
    Processing Record 152 of 500 | westport
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=westport
    Processing Record 153 of 500 | sitka
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=sitka
    Processing Record 154 of 500 | ponta do sol
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=ponta do sol
    Processing Record 155 of 500 | marsh harbour
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=marsh harbour
    Processing Record 156 of 500 | saint-augustin
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=saint-augustin
    Processing Record 157 of 500 | maunabo
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=maunabo
    Processing Record 158 of 500 | tabou
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=tabou
    Processing Record 159 of 500 | newport
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=newport
    Processing Record 160 of 500 | port lincoln
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=port lincoln
    Processing Record 161 of 500 | sobolevo
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=sobolevo
    Processing Record 162 of 500 | san patricio
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=san patricio
    Processing Record 163 of 500 | new richmond
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=new richmond
    Processing Record 164 of 500 | norton shores
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=norton shores
    Processing Record 165 of 500 | hailar
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=hailar
    Processing Record 166 of 500 | lagoa
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=lagoa
    Processing Record 167 of 500 | constitucion
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=constitucion
    Processing Record 168 of 500 | kirakira
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=kirakira
    Processing Record 169 of 500 | port elizabeth
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=port elizabeth
    Processing Record 170 of 500 | lapua
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=lapua
    Processing Record 171 of 500 | yellowknife
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=yellowknife
    Processing Record 172 of 500 | igrim
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=igrim
    Processing Record 173 of 500 | castanheira do ribatejo
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=castanheira do ribatejo
    Processing Record 174 of 500 | airai
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=airai
    Processing Record 175 of 500 | gat
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=gat
    Processing Record 176 of 500 | matay
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=matay
    Processing Record 177 of 500 | paka
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=paka
    Processing Record 178 of 500 | huarmey
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=huarmey
    Processing Record 179 of 500 | quatre cocos
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=quatre cocos
    Processing Record 180 of 500 | jackson
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=jackson
    Processing Record 181 of 500 | santa josefa
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=santa josefa
    Processing Record 182 of 500 | mehamn
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=mehamn
    Processing Record 183 of 500 | taltal
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=taltal
    Processing Record 184 of 500 | monrovia
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=monrovia
    Processing Record 185 of 500 | naze
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=naze
    Processing Record 186 of 500 | kalianget
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=kalianget
    Processing Record 187 of 500 | chapleau
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=chapleau
    Processing Record 188 of 500 | perth
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=perth
    Processing Record 189 of 500 | durban
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=durban
    Processing Record 190 of 500 | bathsheba
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=bathsheba
    Processing Record 191 of 500 | richards bay
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=richards bay
    Processing Record 192 of 500 | mamou
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=mamou
    Processing Record 193 of 500 | redlands
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=redlands
    Processing Record 194 of 500 | bolgar
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=bolgar
    Processing Record 195 of 500 | dunmore east
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=dunmore east
    Processing Record 196 of 500 | tawau
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=tawau
    Processing Record 197 of 500 | lashio
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=lashio
    Processing Record 198 of 500 | mount isa
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=mount isa
    Processing Record 199 of 500 | anloga
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=anloga
    Processing Record 200 of 500 | namatanai
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=namatanai
    Processing Record 201 of 500 | butaritari
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=butaritari
    Processing Record 202 of 500 | bama
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=bama
    Processing Record 203 of 500 | butte
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=butte
    Processing Record 204 of 500 | waraseoni
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=waraseoni
    Processing Record 205 of 500 | araouane
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=araouane
    Processing Record 206 of 500 | broome
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=broome
    Processing Record 207 of 500 | san miguel
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=san miguel
    Processing Record 208 of 500 | panguna
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=panguna
    Processing Record 209 of 500 | castro
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=castro
    Processing Record 210 of 500 | mecca
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=mecca
    Processing Record 211 of 500 | itacoatiara
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=itacoatiara
    Processing Record 212 of 500 | pangai
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=pangai
    Processing Record 213 of 500 | addanki
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=addanki
    Processing Record 214 of 500 | port hardy
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=port hardy
    Processing Record 215 of 500 | ghanzi
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=ghanzi
    Processing Record 216 of 500 | nouakchott
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=nouakchott
    Processing Record 217 of 500 | pevek
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=pevek
    Processing Record 218 of 500 | redwater
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=redwater
    Processing Record 219 of 500 | jumla
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=jumla
    Processing Record 220 of 500 | luanda
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=luanda
    Processing Record 221 of 500 | tokonou
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=tokonou
    Processing Record 222 of 500 | okha
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=okha
    Processing Record 223 of 500 | carnarvon
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=carnarvon
    Processing Record 224 of 500 | namtsy
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=namtsy
    Processing Record 225 of 500 | kultuk
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=kultuk
    Processing Record 226 of 500 | broken hill
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=broken hill
    Processing Record 227 of 500 | dingle
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=dingle
    Processing Record 228 of 500 | tilichiki
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=tilichiki
    Processing Record 229 of 500 | saraland
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=saraland
    Processing Record 230 of 500 | ipixuna
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=ipixuna
    Processing Record 231 of 500 | diego de almagro
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=diego de almagro
    Processing Record 232 of 500 | evensk
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=evensk
    Processing Record 233 of 500 | coihaique
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=coihaique
    Processing Record 234 of 500 | lima
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=lima
    Processing Record 235 of 500 | bonavista
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=bonavista
    Processing Record 236 of 500 | dakar
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=dakar
    Processing Record 237 of 500 | celendin
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=celendin
    Processing Record 238 of 500 | benjamin constant
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=benjamin constant
    Processing Record 239 of 500 | srednekolymsk
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=srednekolymsk
    Processing Record 240 of 500 | tabory
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=tabory
    Processing Record 241 of 500 | saint-joseph
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=saint-joseph
    Processing Record 242 of 500 | acapulco
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=acapulco
    Processing Record 243 of 500 | basco
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=basco
    Processing Record 244 of 500 | manuk mangkaw
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=manuk mangkaw
    Processing Record 245 of 500 | derzhavinsk
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=derzhavinsk
    Processing Record 246 of 500 | tommot
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=tommot
    Processing Record 247 of 500 | erenhot
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=erenhot
    Processing Record 248 of 500 | faya
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=faya
    Processing Record 249 of 500 | aswan
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=aswan
    Processing Record 250 of 500 | hasaki
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=hasaki
    Processing Record 251 of 500 | mao
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=mao
    Processing Record 252 of 500 | yangjiang
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=yangjiang
    Processing Record 253 of 500 | paso de los toros
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=paso de los toros
    Processing Record 254 of 500 | aklavik
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=aklavik
    Processing Record 255 of 500 | mau
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=mau
    Processing Record 256 of 500 | hamilton
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=hamilton
    Processing Record 257 of 500 | madarounfa
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=madarounfa
    Processing Record 258 of 500 | saldanha
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=saldanha
    Processing Record 259 of 500 | uaua
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=uaua
    Processing Record 260 of 500 | san rafael
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=san rafael
    Processing Record 261 of 500 | dom pedrito
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=dom pedrito
    Processing Record 262 of 500 | bethel
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=bethel
    Processing Record 263 of 500 | akdepe
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=akdepe
    Processing Record 264 of 500 | jalu
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=jalu
    Processing Record 265 of 500 | stolin
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=stolin
    Processing Record 266 of 500 | havoysund
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=havoysund
    Processing Record 267 of 500 | ilulissat
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=ilulissat
    Processing Record 268 of 500 | huejuquilla el alto
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=huejuquilla el alto
    Processing Record 269 of 500 | pemba
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=pemba
    Processing Record 270 of 500 | hope mills
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=hope mills
    Processing Record 271 of 500 | ganzhou
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=ganzhou
    Processing Record 272 of 500 | mar del plata
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=mar del plata
    Processing Record 273 of 500 | meulaboh
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=meulaboh
    Processing Record 274 of 500 | caravelas
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=caravelas
    Processing Record 275 of 500 | nelson bay
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=nelson bay
    Processing Record 276 of 500 | khandyga
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=khandyga
    Processing Record 277 of 500 | cody
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=cody
    Processing Record 278 of 500 | panaba
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=panaba
    Processing Record 279 of 500 | chicama
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=chicama
    Processing Record 280 of 500 | dikson
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=dikson
    Processing Record 281 of 500 | omboue
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=omboue
    Processing Record 282 of 500 | las cruces
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=las cruces
    Processing Record 283 of 500 | gazanjyk
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=gazanjyk
    Processing Record 284 of 500 | ndjole
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=ndjole
    Processing Record 285 of 500 | vermillion
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=vermillion
    Processing Record 286 of 500 | arona
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=arona
    Processing Record 287 of 500 | alofi
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=alofi
    Processing Record 288 of 500 | komsomolskiy
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=komsomolskiy
    Processing Record 289 of 500 | gold coast
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=gold coast
    Processing Record 290 of 500 | chara
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=chara
    Processing Record 291 of 500 | ubinskoye
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=ubinskoye
    Processing Record 292 of 500 | salalah
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=salalah
    Processing Record 293 of 500 | tobane
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=tobane
    Processing Record 294 of 500 | portland
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=portland
    Processing Record 295 of 500 | mason city
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=mason city
    Processing Record 296 of 500 | floriano
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=floriano
    Processing Record 297 of 500 | kropotkin
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=kropotkin
    Processing Record 298 of 500 | souillac
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=souillac
    Processing Record 299 of 500 | altay
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=altay
    Processing Record 300 of 500 | college
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=college
    Processing Record 301 of 500 | menongue
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=menongue
    Processing Record 302 of 500 | puerto asis
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=puerto asis
    Processing Record 303 of 500 | padang
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=padang
    Processing Record 304 of 500 | pangnirtung
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=pangnirtung
    Processing Record 305 of 500 | hokitika
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=hokitika
    Processing Record 306 of 500 | winnemucca
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=winnemucca
    Processing Record 307 of 500 | daltenganj
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=daltenganj
    Processing Record 308 of 500 | rosetta
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=rosetta
    Processing Record 309 of 500 | viedma
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=viedma
    Processing Record 310 of 500 | ancud
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=ancud
    Processing Record 311 of 500 | barentu
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=barentu
    Processing Record 312 of 500 | luderitz
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=luderitz
    Processing Record 313 of 500 | jeremie
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=jeremie
    Processing Record 314 of 500 | torbay
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=torbay
    Processing Record 315 of 500 | tevaitoa
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=tevaitoa
    Processing Record 316 of 500 | bud
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=bud
    Processing Record 317 of 500 | kristinehamn
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=kristinehamn
    Processing Record 318 of 500 | dire
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=dire
    Processing Record 319 of 500 | puerto madero
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=puerto madero
    Processing Record 320 of 500 | dryden
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=dryden
    Processing Record 321 of 500 | treinta y tres
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=treinta y tres
    Processing Record 322 of 500 | neryungri
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=neryungri
    Processing Record 323 of 500 | bodmin
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=bodmin
    Processing Record 324 of 500 | victoria
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=victoria
    Processing Record 325 of 500 | nabire
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=nabire
    Processing Record 326 of 500 | cidreira
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=cidreira
    Processing Record 327 of 500 | graaff-reinet
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=graaff-reinet
    Processing Record 328 of 500 | severo-kurilsk
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=severo-kurilsk
    Processing Record 329 of 500 | qaqortoq
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=qaqortoq
    Processing Record 330 of 500 | talnakh
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=talnakh
    Processing Record 331 of 500 | caxito
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=caxito
    Processing Record 332 of 500 | porto belo
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=porto belo
    Processing Record 333 of 500 | murmansk
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=murmansk
    Processing Record 334 of 500 | tonk
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=tonk
    Processing Record 335 of 500 | sorland
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=sorland
    Processing Record 336 of 500 | divnomorskoye
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=divnomorskoye
    Processing Record 337 of 500 | manggar
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=manggar
    Processing Record 338 of 500 | concepcion
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=concepcion
    Processing Record 339 of 500 | kahului
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=kahului
    Processing Record 340 of 500 | thomaston
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=thomaston
    Processing Record 341 of 500 | sisimiut
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=sisimiut
    Processing Record 342 of 500 | izumo
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=izumo
    Processing Record 343 of 500 | ormond beach
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=ormond beach
    Processing Record 344 of 500 | gobabis
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=gobabis
    Processing Record 345 of 500 | kasane
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=kasane
    Processing Record 346 of 500 | sarangani
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=sarangani
    Processing Record 347 of 500 | santa teresa
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=santa teresa
    Processing Record 348 of 500 | shingu
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=shingu
    Processing Record 349 of 500 | kingori
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=kingori
    Processing Record 350 of 500 | kerrville
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=kerrville
    Processing Record 351 of 500 | pampa
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=pampa
    Processing Record 352 of 500 | tiarei
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=tiarei
    Processing Record 353 of 500 | mangrol
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=mangrol
    Processing Record 354 of 500 | metro
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=metro
    Processing Record 355 of 500 | paamiut
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=paamiut
    Processing Record 356 of 500 | oyama
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=oyama
    Processing Record 357 of 500 | khani
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=khani
    Processing Record 358 of 500 | ejido
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=ejido
    Processing Record 359 of 500 | katsuura
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=katsuura
    Processing Record 360 of 500 | bertoua
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=bertoua
    Processing Record 361 of 500 | magadi
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=magadi
    Processing Record 362 of 500 | tashla
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=tashla
    Processing Record 363 of 500 | cockburn town
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=cockburn town
    Processing Record 364 of 500 | oromocto
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=oromocto
    Processing Record 365 of 500 | arlit
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=arlit
    Processing Record 366 of 500 | shestakovo
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=shestakovo
    Processing Record 367 of 500 | atambua
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=atambua
    Processing Record 368 of 500 | fairview
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=fairview
    Processing Record 369 of 500 | iguape
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=iguape
    Processing Record 370 of 500 | tuy hoa
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=tuy hoa
    Processing Record 371 of 500 | clyde river
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=clyde river
    Processing Record 372 of 500 | neuquen
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=neuquen
    Processing Record 373 of 500 | pala
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=pala
    Processing Record 374 of 500 | bosconia
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=bosconia
    Processing Record 375 of 500 | port augusta
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=port augusta
    Processing Record 376 of 500 | lubumbashi
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=lubumbashi
    Processing Record 377 of 500 | zhicheng
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=zhicheng
    Processing Record 378 of 500 | roebourne
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=roebourne
    Processing Record 379 of 500 | rochegda
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=rochegda
    Processing Record 380 of 500 | half moon bay
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=half moon bay
    Processing Record 381 of 500 | umea
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=umea
    Processing Record 382 of 500 | ballina
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=ballina
    Processing Record 383 of 500 | mugur-aksy
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=mugur-aksy
    Processing Record 384 of 500 | malartic
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=malartic
    Processing Record 385 of 500 | flinders
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=flinders
    Processing Record 386 of 500 | inhambane
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=inhambane
    Processing Record 387 of 500 | onguday
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=onguday
    Processing Record 388 of 500 | hovd
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=hovd
    Processing Record 389 of 500 | mayo
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=mayo
    Processing Record 390 of 500 | sibolga
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=sibolga
    Processing Record 391 of 500 | labuan
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=labuan
    Processing Record 392 of 500 | ixtapa
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=ixtapa
    Processing Record 393 of 500 | kannauj
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=kannauj
    Processing Record 394 of 500 | celestun
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=celestun
    Processing Record 395 of 500 | ferkessedougou
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=ferkessedougou
    Processing Record 396 of 500 | abu zabad
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=abu zabad
    Processing Record 397 of 500 | riyadh
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=riyadh
    Processing Record 398 of 500 | pangkalanbuun
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=pangkalanbuun
    Processing Record 399 of 500 | mokhsogollokh
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=mokhsogollokh
    Processing Record 400 of 500 | moa
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=moa
    Processing Record 401 of 500 | ketchikan
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=ketchikan
    Processing Record 402 of 500 | labuhan
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=labuhan
    Processing Record 403 of 500 | alice springs
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=alice springs
    Processing Record 404 of 500 | baghdad
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=baghdad
    Processing Record 405 of 500 | bucerias
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=bucerias
    Processing Record 406 of 500 | pastavy
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=pastavy
    Processing Record 407 of 500 | narsaq
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=narsaq
    Processing Record 408 of 500 | abu dhabi
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=abu dhabi
    Processing Record 409 of 500 | sao joao da barra
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=sao joao da barra
    Processing Record 410 of 500 | ponta delgada
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=ponta delgada
    Processing Record 411 of 500 | vammala
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=vammala
    Processing Record 412 of 500 | hanmer springs
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=hanmer springs
    Processing Record 413 of 500 | canton
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=canton
    Processing Record 414 of 500 | djambala
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=djambala
    Processing Record 415 of 500 | teseney
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=teseney
    Processing Record 416 of 500 | quiruvilca
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=quiruvilca
    Processing Record 417 of 500 | gweta
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=gweta
    Processing Record 418 of 500 | hami
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=hami
    Processing Record 419 of 500 | iquique
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=iquique
    Processing Record 420 of 500 | waipawa
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=waipawa
    Processing Record 421 of 500 | ridgecrest
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=ridgecrest
    Processing Record 422 of 500 | thunder bay
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=thunder bay
    Processing Record 423 of 500 | rawson
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=rawson
    Processing Record 424 of 500 | mana
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=mana
    Processing Record 425 of 500 | traverse city
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=traverse city
    Processing Record 426 of 500 | guhagar
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=guhagar
    Processing Record 427 of 500 | kununurra
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=kununurra
    Processing Record 428 of 500 | chipata
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=chipata
    Processing Record 429 of 500 | byron bay
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=byron bay
    Processing Record 430 of 500 | okhtyrka
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=okhtyrka
    Processing Record 431 of 500 | senno
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=senno
    Processing Record 432 of 500 | sola
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=sola
    Processing Record 433 of 500 | duekoue
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=duekoue
    Processing Record 434 of 500 | salta
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=salta
    Processing Record 435 of 500 | tadine
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=tadine
    Processing Record 436 of 500 | margate
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=margate
    Processing Record 437 of 500 | kapit
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=kapit
    Processing Record 438 of 500 | berlin
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=berlin
    Processing Record 439 of 500 | muriwai beach
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=muriwai beach
    Processing Record 440 of 500 | bay city
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=bay city
    Processing Record 441 of 500 | plettenberg bay
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=plettenberg bay
    Processing Record 442 of 500 | bhuban
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=bhuban
    Processing Record 443 of 500 | villa guerrero
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=villa guerrero
    Processing Record 444 of 500 | jiexiu
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=jiexiu
    Processing Record 445 of 500 | kamenka
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=kamenka
    Processing Record 446 of 500 | hendaye
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=hendaye
    Processing Record 447 of 500 | garden city
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=garden city
    Processing Record 448 of 500 | shiyan
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=shiyan
    Processing Record 449 of 500 | juquitiba
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=juquitiba
    Processing Record 450 of 500 | barreiras
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=barreiras
    Processing Record 451 of 500 | dondo
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=dondo
    Processing Record 452 of 500 | rongai
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=rongai
    Processing Record 453 of 500 | codrington
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=codrington
    Processing Record 454 of 500 | nibbar
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=nibbar
    Processing Record 455 of 500 | agua verde
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=agua verde
    Processing Record 456 of 500 | klaksvik
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=klaksvik
    Processing Record 457 of 500 | christchurch
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=christchurch
    Processing Record 458 of 500 | ohara
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=ohara
    Processing Record 459 of 500 | shimoda
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=shimoda
    Processing Record 460 of 500 | kharp
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=kharp
    Processing Record 461 of 500 | kiunga
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=kiunga
    Processing Record 462 of 500 | thaba-tseka
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=thaba-tseka
    Processing Record 463 of 500 | waingapu
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=waingapu
    Processing Record 464 of 500 | kitale
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=kitale
    Processing Record 465 of 500 | bydgoszcz
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=bydgoszcz
    Processing Record 466 of 500 | kurumkan
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=kurumkan
    Processing Record 467 of 500 | sindor
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=sindor
    Processing Record 468 of 500 | nagapattinam
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=nagapattinam
    Processing Record 469 of 500 | rock springs
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=rock springs
    Processing Record 470 of 500 | pamanukan
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=pamanukan
    Processing Record 471 of 500 | pontes e lacerda
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=pontes e lacerda
    Processing Record 472 of 500 | peniche
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=peniche
    Processing Record 473 of 500 | praia da vitoria
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=praia da vitoria
    Processing Record 474 of 500 | ngerengere
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=ngerengere
    Processing Record 475 of 500 | vangaindrano
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=vangaindrano
    Processing Record 476 of 500 | requena
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=requena
    Processing Record 477 of 500 | ybycui
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=ybycui
    Processing Record 478 of 500 | vao
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=vao
    Processing Record 479 of 500 | faanui
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=faanui
    Processing Record 480 of 500 | goure
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=goure
    Processing Record 481 of 500 | vila velha
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=vila velha
    Processing Record 482 of 500 | tocopilla
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=tocopilla
    Processing Record 483 of 500 | kiama
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=kiama
    Processing Record 484 of 500 | gaspar
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=gaspar
    Processing Record 485 of 500 | morehead
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=morehead
    Processing Record 486 of 500 | verkhoturye
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=verkhoturye
    Processing Record 487 of 500 | dzheguta
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=dzheguta
    Processing Record 488 of 500 | petropavlovsk-kamchatskiy
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=petropavlovsk-kamchatskiy
    Processing Record 489 of 500 | lubao
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=lubao
    Processing Record 490 of 500 | vila franca do campo
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=vila franca do campo
    Processing Record 491 of 500 | robertsport
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=robertsport
    Processing Record 492 of 500 | port-gentil
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=port-gentil
    Processing Record 493 of 500 | rudnaya pristan
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=rudnaya pristan
    Processing Record 494 of 500 | guadalupe y calvo
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=guadalupe y calvo
    Processing Record 495 of 500 | camapua
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=camapua
    Processing Record 496 of 500 | danane
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=danane
    Processing Record 497 of 500 | lac du bonnet
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=lac du bonnet
    Processing Record 498 of 500 | beringovskiy
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=beringovskiy
    Processing Record 499 of 500 | athabasca
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=athabasca
    Processing Record 500 of 500 | kuryk
    http://api.openweathermap.org/data/2.5/weather?appid=68849a8dc03a9447c9dbfd458a9196f7&units=imperial&q=kuryk
    ------------------------------
    Data Retrieval Complete
    ------------------------------
    

# Consolidate Weather Data


```python
data = {"City" : cities, "Country": countries, "Date": date,"Latitude": latitude, "Max Temp": max_temp,\
        "Humidity": humidity, "Cloudiness": clouds, "Wind Speed": wind_speed}
city_weather = pd.DataFrame(data)
city_weather.to_csv("city_weather.csv")
city_weather.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>City</th>
      <th>Cloudiness</th>
      <th>Country</th>
      <th>Date</th>
      <th>Humidity</th>
      <th>Latitude</th>
      <th>Max Temp</th>
      <th>Wind Speed</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>saint-philippe</td>
      <td>1</td>
      <td>re</td>
      <td>1527648900</td>
      <td>76</td>
      <td>45.36</td>
      <td>68.00</td>
      <td>5.50</td>
    </tr>
    <tr>
      <th>1</th>
      <td>plast</td>
      <td>12</td>
      <td>pf</td>
      <td>1527650933</td>
      <td>61</td>
      <td>54.37</td>
      <td>43.86</td>
      <td>6.17</td>
    </tr>
    <tr>
      <th>2</th>
      <td>rikitea</td>
      <td>0</td>
      <td>jp</td>
      <td>1527648764</td>
      <td>100</td>
      <td>-23.12</td>
      <td>75.45</td>
      <td>9.19</td>
    </tr>
    <tr>
      <th>3</th>
      <td>albany</td>
      <td>20</td>
      <td>sh</td>
      <td>1527645240</td>
      <td>37</td>
      <td>42.65</td>
      <td>71.60</td>
      <td>9.17</td>
    </tr>
    <tr>
      <th>4</th>
      <td>amberley</td>
      <td>0</td>
      <td>us</td>
      <td>1527649200</td>
      <td>75</td>
      <td>-43.15</td>
      <td>46.40</td>
      <td>2.24</td>
    </tr>
  </tbody>
</table>
</div>



# Latitude vs. Temperature Plot


```python
plt.scatter(city_weather["Latitude"], city_weather["Max Temp"], marker="o", facecolors="blue", edgecolors="black", alpha=0.75)
plt.title("City Latitude vs. Max Temperature (05/29/2018)")
plt.xlabel("Latitude")
plt.ylabel("Max Temperature (F)")
plt.xlim(-90, 90)
plt.ylim(0,120)
plt.grid(alpha=.7)
plt.savefig("max_temp.png")
plt.show()

```


![png](output_8_0.png)


# Latitude vs. Humidity Plot 


```python
plt.scatter(city_weather["Latitude"], city_weather["Humidity"], marker="o", facecolors="blue", edgecolors="black", alpha=0.75)
plt.title("City Latitude vs. Humidity (05/29/2018)")
plt.xlabel("Latitude")
plt.ylabel("Humidity (%)")
plt.xlim(-90, 90)
plt.ylim(-10,120)
plt.grid(alpha=.7)
plt.savefig("humidity.png")
plt.show()
```


![png](output_10_0.png)


# Latitude vs. Cloudiness Plot


```python
plt.scatter(city_weather["Latitude"], city_weather["Cloudiness"], marker="o", facecolors="blue", edgecolors="black", alpha=0.75)
plt.title("City Latitude vs. Cloudiness (05/29/2018)")
plt.xlabel("Latitude")
plt.ylabel("Cloudiness (%)")
plt.xlim(-90, 90)
plt.ylim(-20,120)
plt.grid(alpha=.7)
plt.savefig("cloudiness.png")
plt.show()
```


![png](output_12_0.png)


# Latitude vs. Wind Speed Plot


```python
plt.scatter(city_weather["Latitude"], city_weather["Wind Speed"], marker="o", facecolors="blue", edgecolors="black", alpha=0.75)
plt.title("City Latitude vs. Wind Speed (05/29/2018)")
plt.xlabel("Latitude")
plt.ylabel("Wind Speed (mph)")
plt.xlim(-90, 90)
plt.ylim(-5,60)
plt.grid(alpha=.7)
plt.savefig("wind_speed.png")
plt.show()
```


![png](output_14_0.png)

