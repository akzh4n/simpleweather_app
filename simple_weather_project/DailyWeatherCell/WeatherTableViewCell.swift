//
//  WeatherTableViewCell.swift
//  simple_weather_project
//
//  Created by Акжан Калиматов on 17.08.2022.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet var dayLabel:         UILabel!
    @IBOutlet var highTempLabel:    UILabel!
    @IBOutlet var lowTempLabel:     UILabel!
    @IBOutlet var iconImageView:    UIImageView!
    
    static let identifier = "WeatherTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dayLabel.textColor =        .white
        highTempLabel.textColor =   .white
        lowTempLabel.textColor =    .white
        iconImageView.tintColor =   .white
        backgroundColor =           .clear
    }
    
    func configure(with model: DailyWeatherEntry) {
        
        self.dayLabel.text = getDayFromDate(Date(timeIntervalSince1970: Double(model.time)))
        self.lowTempLabel.text = "\(convertToCelsius(model.temperatureLow))"
        self.highTempLabel.text = "\(convertToCelsius(model.temperatureHigh))"
        
        let icon = model.icon.lowercased()
        if icon.contains("clear") {
            self.iconImageView.image = UIImage(systemName: "sun.max")
        } else if icon.contains("rain") {
            self.iconImageView.image = UIImage(systemName: "cloud.rain")
        } else {
            self.iconImageView.image = UIImage(systemName: "cloud")
        }
    }
    
    func getDayFromDate(_ date: Date?) -> String {
        
        guard let inputDate = date else { return ""}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: inputDate)
    }
    
    func convertToCelsius(_ fahrenheit: Double) -> Int {
        return Int(5.0 / 9.0 * (Double(fahrenheit) - 32.0))
    }
}

