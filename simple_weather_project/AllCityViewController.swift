//
//  AllCityViewController.swift
//  simple_weather_project
//
//  Created by Акжан Калиматов on 20.08.2022.
//

import UIKit
import CoreLocation

class AllCityViewController: UIViewController {

    @IBOutlet weak var firstCityLabel: UILabel!
    
    
    @IBOutlet weak var firstWeatherIcon: UIImageView!
    
    @IBOutlet weak var firstTempLabel: UILabel!
    
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    

 

}



extension AllCityViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        
        DispatchQueue.main.async {
            
            let icon = weather.icon
            
            if icon.contains("n") {
                
                self.firstWeatherIcon.image = UIImage.init(systemName: weather.nightConditionName)
                
            } else if icon.contains("d") {
                
                self.firstWeatherIcon.image = UIImage.init(systemName: weather.dayConditionName)
            }
            
            
            self.firstCityLabel.text = weather.cityName
            self.firstTempLabel.text = weather.currentTemperatureString + " ºC"
            
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}



extension AllCityViewController: CLLocationManagerDelegate {
    
    
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
