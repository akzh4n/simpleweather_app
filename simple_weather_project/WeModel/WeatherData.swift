//
//  WeatherData.swift
//  simple_weather_project
//
//  Created by Акжан Калиматов on 16.08.2022.
//

import Foundation

struct WeatherData: Decodable{
    let name: String;
    let main: Main;
    let weather: [Weather];
}

struct Main: Decodable {
    let temp: Double;
}

struct Weather: Decodable {
    let id: Int;
}

