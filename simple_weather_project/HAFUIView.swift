//
//  HAFUIView.swift
//  simple_weather_project
//
//  Created by Акжан Калиматов on 17.08.2022.
//

import UIKit




extension WeatherViewController {
    //MARK: - Adding a Separator Line
    func createSeparateLine(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> UIView {
        let line = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        line.layer.borderWidth = 1.0
        line.layer.borderColor = UIColor.white.cgColor
        line.alpha = 0.37
        return line
    }
    
    //MARK: - Table View Header
    func createTableHeader() -> UIView {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0,
                                              width: view.frame.size.width,
                                              height: 200))
        
        // Temperature Label Setting
        let temperatureLabel = UILabel(frame: CGRect(x: 10, y: 10,
                                                     width: view.frame.size.width,
                                                     height: 100))
        
        temperatureLabel.textColor = .white
        temperatureLabel.font = UIFont(name: "Arial", size: 90)
        temperatureLabel.textAlignment = .center
        headerView.addSubview(temperatureLabel)
        
        guard let currentWeather = self.currentWeather else { return UIView() }
        temperatureLabel.text = "\(convertToCelsius(currentWeather.temperature))°"
        
        // Current Day Label Setting
        let currentDayLabel = UILabel(frame: CGRect(x: 20,
                                                    y: headerView.frame.size.height - 25,
                                                    width: view.frame.size.width / 4,
                                                    height: 20))
        
        let currentDay = getDayFromDate(Date(timeIntervalSince1970: Double(dailyModels[0].time)))
        currentDayLabel.text = "\(currentDay)"
        currentDayLabel.textColor = .white
        currentDayLabel.textAlignment = .left
        currentDayLabel.font = UIFont(name: "Arial", size: 15)
        headerView.addSubview(currentDayLabel)
        
        let todayLabel = UILabel(frame: CGRect(x: currentDayLabel.frame.size.width + 20,
                                               y: headerView.frame.size.height - 25,
                                               width: view.frame.size.width / 4,
                                               height: currentDayLabel.frame.size.height))
        todayLabel.text = "Today"
        todayLabel.textColor = .white
        todayLabel.textAlignment = .left
        todayLabel.font = UIFont(name: "Arial", size: 15)
        headerView.addSubview(todayLabel)
        
        // Current High and Low Temperature
        let currentHighTempLabel = UILabel(frame: CGRect(x: headerView.frame.size.width - 90,
                                                         y: headerView.frame.size.height - 25,
                                                         width: 30,
                                                         height: currentDayLabel.frame.size.height))
        currentHighTempLabel.text = "\(convertToCelsius(self.dailyModels[0].temperatureHigh))"
        currentHighTempLabel.textColor = .white
        currentHighTempLabel.textAlignment = .right
        currentHighTempLabel.font = UIFont(name: "Arial", size: 15)
        headerView.addSubview(currentHighTempLabel)
        
        let currentLowTempLabel = UILabel(frame: CGRect(x: headerView.frame.size.width - 50,
                                                        y: headerView.frame.size.height - 25,
                                                        width: 30,
                                                        height: currentDayLabel.frame.size.height))
        currentLowTempLabel.text = "\(convertToCelsius(self.dailyModels[0].temperatureLow))"
        currentLowTempLabel.textColor = .white
        currentLowTempLabel.textAlignment = .right
        currentLowTempLabel.font = UIFont(name: "Arial", size: 15)
        headerView.addSubview(currentLowTempLabel)
        
        return headerView
    }
    
    //MARK: - Table View Footer
    func createTableFooter() -> UIView {
        
        let footerView = UIView(frame: CGRect(x: 0,
                                              y: table.frame.minY,
                                              width: view.frame.size.width,
                                              height: 400))
        
        // –––––––––––––––––––––––––––––––––––
        footerView.addSubview(createSeparateLine(x: 0, y: 0, width: view.frame.size.width, height: 1.0))
        
        // Summary LABEL
        let summaryLabel = UILabel(frame: CGRect(x: 20,
                                                 y: 0,
                                                 width: footerView.frame.size.width - 40,
                                                 height: 60))
        
        guard let currentWeather = self.currentWeather else { return UIView() }
        summaryLabel.text = "Today: \(currentWeather.summary) currently. It's \(convertToCelsius(currentWeather.temperature))°; the high today was forecast \(convertToCelsius(self.dailyModels[0].temperatureHigh))°"
        summaryLabel.textColor = .white
        summaryLabel.textAlignment = .left
        summaryLabel.numberOfLines = 0
        summaryLabel.font = UIFont(name: "Arial", size: 15)
        footerView.addSubview(summaryLabel)
        // –––––––––––––––––––––––––––––––––––
        footerView.addSubview(
            createSeparateLine(x: 0, y: 60, width: view.frame.size.width, height: 1.0))
        
        // SUNRISE LABELS
        let sunriseTitle = UILabel(frame: CGRect(x: 20,
                                                 y: 70,
                                                 width: view.frame.size.width / 3,
                                                 height: 15))
        sunriseTitle.text = "SUNRISE"
        sunriseTitle.textColor = .white
        sunriseTitle.textAlignment = .left
        sunriseTitle.font = UIFont(name: "Arial", size: 10)
        sunriseTitle.alpha = 0.5
        footerView.addSubview(sunriseTitle)
        
        let sunriseTime = UILabel(frame: CGRect(x: 20,
                                                y: 83,
                                                width: view.frame.size.width / 3,
                                                height: 30))
        sunriseTime.text = getTimeFromDate(Date(timeIntervalSince1970: Double(dailyModels[0].sunriseTime)))
        sunriseTime.textColor = .white
        sunriseTime.textAlignment = .left
        sunriseTime.font = UIFont(name: "Arial", size: 27)
        footerView.addSubview(sunriseTime)
        
        // SUNSET LABELS
        let sunsetTitle = UILabel(frame: CGRect(x: view.frame.size.width / 2,
                                                y: 70,
                                                width: view.frame.size.width / 3,
                                                height: 15))
        sunsetTitle.text = "SUNSET"
        sunsetTitle.textColor = .white
        sunsetTitle.textAlignment = .left
        sunsetTitle.font = UIFont(name: "Arial", size: 10)
        sunsetTitle.alpha = 0.5
        footerView.addSubview(sunsetTitle)
        
        let sunsetTime = UILabel(frame: CGRect(x: view.frame.size.width / 2,
                                               y: 83,
                                               width: view.frame.size.width / 3,
                                               height: 30))
        sunsetTime.text = getTimeFromDate(Date(timeIntervalSince1970: Double(dailyModels[0].sunsetTime)))
        sunsetTime.textColor = .white
        sunsetTime.textAlignment = .left
        sunsetTime.font = UIFont(name: "Arial", size: 27)
        footerView.addSubview(sunsetTime)
        
        // –––––––––––––––––––––––––––––––––––
        footerView.addSubview(createSeparateLine(x: 20,
                                                 y: 120,
                                                 width: view.frame.size.width - 40,
                                                 height: 1.0))
        
        // CHANCE OF RAIN LABELS
        let chanceOfRainTitle = UILabel(frame: CGRect(x: 20,
                                                      y: 130,
                                                      width: view.frame.size.width / 3,
                                                      height: 15))
        chanceOfRainTitle.text = "CHANCE OF RAIN"
        chanceOfRainTitle.textColor = .white
        chanceOfRainTitle.textAlignment = .left
        chanceOfRainTitle.font = UIFont(name: "Arial", size: 10)
        chanceOfRainTitle.alpha = 0.5
        footerView.addSubview(chanceOfRainTitle)
        
        let chanceOfRainNumber = UILabel(frame: CGRect(x: 20,
                                                       y: 143,
                                                       width: view.frame.size.width / 3,
                                                       height: 30))
        chanceOfRainNumber.text = "\(dailyModels[0].precipProbability)%"
        chanceOfRainNumber.textColor = .white
        chanceOfRainNumber.textAlignment = .left
        chanceOfRainNumber.font = UIFont(name: "Arial", size: 27)
        footerView.addSubview(chanceOfRainNumber)
        
        // HUMIDITY LABELS
        let humidityTitle = UILabel(frame: CGRect(x: view.frame.size.width / 2,
                                                  y: 130,
                                                  width: view.frame.size.width / 3,
                                                  height: 15))
        humidityTitle.text = "HUMIDITY"
        humidityTitle.textColor = .white
        humidityTitle.textAlignment = .left
        humidityTitle.font = UIFont(name: "Arial", size: 10)
        humidityTitle.alpha = 0.5
        footerView.addSubview(humidityTitle)
        
        let humidityNumber = UILabel(frame: CGRect(x: view.frame.size.width / 2,
                                                   y: 143,
                                                   width: view.frame.size.width / 3,
                                                   height: 30))
        humidityNumber.text = "\(dailyModels[0].humidity)%"
        humidityNumber.textColor = .white
        humidityNumber.textAlignment = .left
        humidityNumber.font = UIFont(name: "HelveticaNeue", size: 27)
        footerView.addSubview(humidityNumber)
        
        // –––––––––––––––––––––––––––––––––––
        footerView.addSubview(createSeparateLine(x: 20,
                                                 y: 180,
                                                 width: view.frame.size.width - 40,
                                                 height: 1.0))
        
        // WIND LABELS
        let windTitle = UILabel(frame: CGRect(x: 20,
                                              y: 190,
                                              width: view.frame.size.width / 3,
                                              height: 15))
        windTitle.text = "WIND"
        windTitle.textColor = .white
        windTitle.textAlignment = .left
        windTitle.font = UIFont(name: "Arial", size: 10)
        windTitle.alpha = 0.5
        footerView.addSubview(windTitle)
        
        let windNumber = UILabel(frame: CGRect(x: 20,
                                               y: 203,
                                               width: view.frame.size.width / 3,
                                               height: 30))
        windNumber.text = "\(dailyModels[0].windSpeed) km/h"
        windNumber.textColor = .white
        windNumber.textAlignment = .left
        windNumber.font = UIFont(name: "HelveticaNeue", size: 27)
        footerView.addSubview(windNumber)
        
        // FEELS LIKE LABELS
        let feelsLikeTitle = UILabel(frame: CGRect(x: view.frame.size.width / 2,
                                                   y: 190,
                                                   width: view.frame.size.width / 3,
                                                   height: 15))
        feelsLikeTitle.text = "FEELS LIKE"
        feelsLikeTitle.textColor = .white
        feelsLikeTitle.textAlignment = .left
        feelsLikeTitle.font = UIFont(name: "Arial", size: 10)
        feelsLikeTitle.alpha = 0.5
        footerView.addSubview(feelsLikeTitle)
        
        let feelsLikeNumber = UILabel(frame: CGRect(x: view.frame.size.width / 2,
                                                    y: 203,
                                                    width: view.frame.size.width / 3,
                                                    height: 30))
        feelsLikeNumber.text = "\(convertToCelsius(currentWeather.temperature))°"
        feelsLikeNumber.textColor = .white
        feelsLikeNumber.textAlignment = .left
        feelsLikeNumber.font = UIFont(name: "Arial", size: 27)
        footerView.addSubview(feelsLikeNumber)
        
        // –––––––––––––––––––––––––––––––––––
        footerView.addSubview(createSeparateLine(x: 20,
                                                 y: 240,
                                                 width: view.frame.size.width - 40,
                                                 height: 1.0))
        
        // PRECIPITATION LABELS
        let precipitationTitle = UILabel(frame: CGRect(x: 20,
                                                       y: 250,
                                                       width: view.frame.size.width / 3,
                                                       height: 15))
        precipitationTitle.text = "PRECIPITATION"
        precipitationTitle.textColor = .white
        precipitationTitle.textAlignment = .left
        precipitationTitle.font = UIFont(name: "Arial", size: 10)
        precipitationTitle.alpha = 0.5
        footerView.addSubview(precipitationTitle)
        
        let precipitationNumber = UILabel(frame: CGRect(x: 20,
                                                        y: 263,
                                                        width: view.frame.size.width / 3,
                                                        height: 30))
        precipitationNumber.text = "\(Int(dailyModels[0].precipIntensity)) cm"
        precipitationNumber.textColor = .white
        precipitationNumber.textAlignment = .left
        precipitationNumber.font = UIFont(name: "HelveticaNeue", size: 27)
        footerView.addSubview(precipitationNumber)
        
        // PRESSURE LABELS
        let pressureTitle = UILabel(frame: CGRect(x: view.frame.size.width / 2,
                                                  y: 250,
                                                  width: view.frame.size.width / 3,
                                                  height: 15))
        pressureTitle.text = "PRESSURE"
        pressureTitle.textColor = .white
        pressureTitle.textAlignment = .left
        pressureTitle.font = UIFont(name: "Arial", size: 10)
        pressureTitle.alpha = 0.5
        footerView.addSubview(pressureTitle)
        
        let pressureNumber = UILabel(frame: CGRect(x: view.frame.size.width / 2,
                                                   y: 263,
                                                   width: view.frame.size.width / 3,
                                                   height: 30))
        pressureNumber.text = "\(Int(dailyModels[0].pressure)) hPa"
        pressureNumber.textColor = .white
        pressureNumber.textAlignment = .left
        pressureNumber.font = UIFont(name: "Arial", size: 27)
        footerView.addSubview(pressureNumber)
        
        // –––––––––––––––––––––––––––––––––––
        footerView.addSubview(createSeparateLine(x: 20,
                                                 y: 300,
                                                 width: view.frame.size.width - 40,
                                                 height: 1.0))
        // VISIBILITY LABELS
        let visibilityTitle = UILabel(frame: CGRect(x: 20,
                                                    y: 310,
                                                    width: view.frame.size.width / 3,
                                                    height: 15))
        visibilityTitle.text = "VISIBILITY"
        visibilityTitle.textColor = .white
        visibilityTitle.textAlignment = .left
        visibilityTitle.font = UIFont(name: "Arial", size: 10)
        visibilityTitle.alpha = 0.5
        footerView.addSubview(visibilityTitle)
        
        let visibilityNumber = UILabel(frame: CGRect(x: 20,
                                                     y: 323,
                                                     width: view.frame.size.width / 3,
                                                     height: 30))
        visibilityNumber.text = "\(String(format: "%.1f", dailyModels[0].visibility)) km"
        visibilityNumber.textColor = .white
        visibilityNumber.textAlignment = .left
        visibilityNumber.font = UIFont(name: "HelveticaNeue", size: 27)
        footerView.addSubview(visibilityNumber)
        
        // UV INDEX LABELS
        let uvIndexTitle = UILabel(frame: CGRect(x: view.frame.size.width / 2,
                                                  y: 310,
                                                  width: view.frame.size.width / 3,
                                                  height: 15))
        uvIndexTitle.text = "UV INDEX"
        uvIndexTitle.textColor = .white
        uvIndexTitle.textAlignment = .left
        uvIndexTitle.font = UIFont(name: "Arial", size: 10)
        uvIndexTitle.alpha = 0.5
        footerView.addSubview(uvIndexTitle)
        
        let uvIndexNumber = UILabel(frame: CGRect(x: view.frame.size.width / 2,
                                                   y: 323,
                                                   width: view.frame.size.width / 3,
                                                   height: 30))
        uvIndexNumber.text = "\(dailyModels[0].uvIndex)"
        uvIndexNumber.textColor = .white
        uvIndexNumber.textAlignment = .left
        uvIndexNumber.font = UIFont(name: "Arial", size: 27)
        footerView.addSubview(uvIndexNumber)
        
        // –––––––––––––––––––––––––––––––––––
        footerView.addSubview(createSeparateLine(x: 20,
                                                 y: 360,
                                                 width: view.frame.size.width - 40,
                                                 height: 1.0))
        
        return footerView
    }
    
    //MARK: Get Date
    func getDayFromDate(_ date: Date?) -> String {
        
        guard let inputDate = date else { return ""}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: inputDate)
    }
    
    func getTimeFromDate(_ date: Date?) -> String {
        
        guard let inputDate = date else { return ""}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: inputDate)
    }
    
    func convertToCelsius(_ fahrenheit: Double) -> Int {
        return Int(5.0 / 9.0 * (Double(fahrenheit) - 32.0))
    }
}

