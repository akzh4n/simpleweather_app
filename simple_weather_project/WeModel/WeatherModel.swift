//
//  WeatherModel.swift
//  simple_weather_project
//
//  Created by Акжан Калиматов on 17.08.2022.
//

import UIKit

struct WeatherResponse: Codable {
    let latitude:   Float
    let longitude:  Float
    let timezone:   String
    let currently:  CurrentWeather
    let hourly:     HourlyWeather
    let daily:      DailyWeather
    let offset:     Float
    
}




struct CurrentWeather: Codable {
    let conditionId:            Int
    let time:                   Int
    let summary:                String
    let icon:                   String
    //let nearestStormDistance:   Int
    //let nearestStormBearing:    Int
    //let precipIntensity:        Int
    //let precipProbability:      Int
    let temperature:            Double
    let apparentTemperature:    Double
    let dewPoint:               Double
    let humidity:               Double
    let pressure:               Double
    let windSpeed:              Double
    let windGust:               Double
    let windBearing:            Int
    let cloudCover:             Double
    let uvIndex:                Int
    let visibility:             Double
    let ozone:                  Double
    
    
    
    
    var conditionName: String {
            
            switch conditionId {
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...622:
                    return "cloud.snow"
                case 701...781:
                    return "cloud.fog"
                case 800:
                    return "sun.max"
                case 801...804:
                    return "cloud.bolt"
                default:
                    return "cloud"
            }
            
        }
}

struct HourlyWeather: Codable {
    
    let summary:    String
    let icon:       String
    let data:       [HourlyWeatherEntry]
}

struct HourlyWeatherEntry: Codable {
    
    let time:                   Int
    let summary:                String
    let icon:                   String
    let precipIntensity:        Float
    let precipProbability:      Double
    let precipType:             String?
    let temperature:            Double
    let apparentTemperature:    Double
    let dewPoint:               Double
    let humidity:               Double
    let pressure:               Double
    let windSpeed:              Double
    let windGust:               Double
    let windBearing:            Int
    let cloudCover:             Double
    let uvIndex:                Int
    let visibility:             Double
    let ozone:                  Double
}

struct DailyWeather: Codable {
    
    let summary:    String
    let icon:       String
    let data:       [DailyWeatherEntry]
}

struct DailyWeatherEntry: Codable {
    
    let time:                           Int
    let summary:                        String
    let icon:                           String
    let sunriseTime:                    Int
    let sunsetTime:                     Int
    let moonPhase:                      Double
    let precipIntensity:                Float
    let precipIntensityMax:             Float
    let precipIntensityMaxTime:         Int
    let precipProbability:              Double
    let precipType:                     String?
    let temperatureHigh:                Double
    let temperatureHighTime:            Int
    let temperatureLow:                 Double
    let temperatureLowTime:             Int
    let apparentTemperatureHigh:        Double
    let apparentTemperatureHighTime:    Int
    let apparentTemperatureLow:         Double
    let apparentTemperatureLowTime:     Int
    let dewPoint:                       Double
    let humidity:                       Double
    let pressure:                       Double
    let windSpeed:                      Double
    let windGust:                       Double
    let windGustTime:                   Int
    let windBearing:                    Int
    let cloudCover:                     Double
    let uvIndex:                        Int
    let uvIndexTime:                    Int
    let visibility:                     Double
    let ozone:                          Double
    let temperatureMin:                 Double
    let temperatureMinTime:             Int
    let temperatureMax:                 Double
    let temperatureMaxTime:             Int
    let apparentTemperatureMin:         Double
    let apparentTemperatureMinTime:     Int
    let apparentTemperatureMax:         Double
    let apparentTemperatureMaxTime:     Int
}



