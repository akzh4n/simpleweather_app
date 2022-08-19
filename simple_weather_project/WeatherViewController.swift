//
//  WeatherViewController.swift
//  simple_weather_project
//
//  Created by Акжан Калиматов on 16.08.2022.
//


import UIKit
import CoreLocation


class WeatherViewController: UIViewController {
    
    
   
 
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var conditionImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
   
    
    // MARK: - View Controller Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        searchTextField.delegate = self
        
        // Must set locationManager delegate before requesting location.
        locationManager.delegate = self
        
        // Send location permission request.
        locationManager.requestWhenInUseAuthorization()
        
        // Request intial location fix.
        locationManager.startUpdatingLocation()
        
        weatherManager.delegate = self
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    
    
    func searchComplete(){
        let searchText = searchTextField.text!
        searchTextField.endEditing(true)
    }
    
}


extension WeatherViewController: UITextFieldDelegate {
    
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchComplete()
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != ""{
            return true
        }else{
            textField.placeholder = "Please type something here"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}
    
   
    
    




// MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        
        DispatchQueue.main.async {
            
            let icon = weather.icon
            
            if icon.contains("n") {
                
                self.conditionImage.image = UIImage.init(systemName: weather.nightConditionName)
                
            } else if icon.contains("d") {
                
                self.conditionImage.image = UIImage.init(systemName: weather.dayConditionName)
            }
            
            self.descriptionLabel.text = weather.description.capitalizingFirstLetter()
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.currentTemperatureString
            self.feelsLikeLabel.text = weather.feelsLikeString + " ºC"
            self.pressureLabel.text = weather.pressureString + " hPa"
            self.humidityLabel.text = weather.humidityString + " %"
            self.minTemperatureLabel.text = weather.lowTemperatureString + " ºC"
            self.maxTemperatureLabel.text = weather.highTemperatureString + " ºC"
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

// MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    
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
}





// MARK: - String Extension

extension String {
    
    func capitalizingFirstLetter() -> String {
        
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        
        self = self.capitalizingFirstLetter()
    }
}






