
<p align="left">
  <img src="https://github.com/manste1n/simpleweather_app/blob/main/Screens/mainicon.png" width="100" title="main">
</p>






# SimpleWeather

This simple app is my first pet project in iOS Development by using Swift Language. 
I tried to make the interface and features as user-friendly as possible.
The app runs on iOS and iPadOS. The project will evolve with the different betas of Xcode.

<p align="center">
  <img src="https://github.com/manste1n/simpleweather_app/blob/main/Screens/1.png" width="300" title="1">
  <img src="https://github.com/manste1n/simpleweather_app/blob/main/Screens/2.png" width="300" title="2">
  
</p>



<p align="left">
  <img src="https://github.com/manste1n/simpleweather_app/blob/main/Screens/3.png" width="200" title="3">
  <img src="https://github.com/manste1n/simpleweather_app/blob/main/Screens/4.png" width="200" title="4">
  
</p>




## Features

- [x] Gets current location and Weather information for this location
- [x] Beautiful UI design
- [x] Ability to search for locations
- [x] Overview of the cities [not full]
- [x] Open to all devices 



## API

SimpleWeather App - uses the [OpenWeather API](https://openweathermap.org) to fetch weather datas. It uses a free API key thereby it only has a 3 hours and 5 days forecast.

## Code Review

 - Weather Data
 ```sh
struct WeatherData: Codable {
    let name: String
    let message: String?
    let main: Main
    let weather: [Weather]
    let sys: Sys
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let humidity: Double
}

struct Weather: Codable {
    let id: Int
    let description: String
    let icon: String
}

struct Sys: Codable {
    let country: String
}

``` 

 - Connecting API
 ```sh
 let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=imperial&appid=[TEXT YOUR API KEY]"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        
        if cityName.contains(" ") {
            
            let cityWithSpaces = cityName.replacingOccurrences(of: " ", with: "+")
            let urlString = "\(weatherURL)&q=\(cityWithSpaces)"
            performRequest(with: urlString)
            
        } else {
            
            let urlString = "\(weatherURL)&q=\(cityName)"
            performRequest(with: urlString)
        }
    }
    
   
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
``` 



 - Location Manager Delegate
 ```sh
@IBAction func locationButtonPressed(_ sender: UIButton) {
        
        print("Location button pressed")
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("Error: \(error)")
    }
``` 


## Installation

#### Requirements
- Xcode 13+ with an iOS 13.0+ simulator
- An OpenWeatherMap API key

#### Installation steps
1. Clone the repo: `git clone https://github.com/manste1n/simpleweather_app`
2. Add a Constants.swift file in the root folder of your project (same folder with Info.plist, Assets.xcassets, etc)
3. Add the OpenWeatherMap API key and URL




&nbsp;



Thx for attention :3

You can support me by following :>
