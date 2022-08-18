//
//  WeatherData.swift
//  simple_weather_project
//
//  Created by Акжан Калиматов on 19.08.2022.
//


// A struct that conforms to the Decodable protocol is a type that can decode itself from an external representation (JSON representation).

import Foundation

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
