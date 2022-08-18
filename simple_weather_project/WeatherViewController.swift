//
//  WeatherViewController.swift
//  simple_weather_project
//
//  Created by Акжан Калиматов on 16.08.2022.
//


import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
   
    
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var conditionImage: UIImageView!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var table: UITableView!
    
    var dailyModels = [DailyWeatherEntry]()
    var hourlyModels = [HourlyWeatherEntry]()
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var currentWeather: CurrentWeather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    
        // Cells register
        table.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: "HourlyTableViewCell")
        table.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: "WeatherTableViewCell")
        
        table.delegate = self
        table.dataSource = self
        
        table.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        table.addSubview(createSeparateLine(x: 0, y: 200, width: view.frame.size.width, height: 1.0))
        table.addSubview(createSeparateLine(x: 0, y: 320, width: view.frame.size.width, height: 1.0))
        
        
    }
    
    
    func searchComplete(){
            let searchText = searchTF.text!
            searchTF.endEditing(true)
        }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupLocation()
    }
    
    
    
    
}





extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return dailyModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HourlyTableViewCell.identifier, for: indexPath) as! HourlyTableViewCell
            cell.configure(with: hourlyModels)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        cell.configure(with: dailyModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 120
        }
        // Hide Row with Current Data
        if indexPath.row == 0 {
            return 0
        }
        return 40
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    
    // Location Setup
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    
    func requestWeatherForLocation() {
        
        guard let currentLocation = currentLocation else { return }
        let latitude = currentLocation.coordinate.latitude
        let longitude = currentLocation.coordinate.longitude
        
        let url = "https://api.darksky.net/forecast/deabd75bf7e8486ffe1df7b9929f5fb7/\(latitude),\(longitude)?exclude=[flags,minutely]"
        
        
        
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            
            DispatchQueue.main.async {
                
                guard let data = data, error == nil else { return }
                
                var json: WeatherResponse?
                
                do {
                    json = try JSONDecoder().decode(WeatherResponse.self, from: data)
                } catch {
                    print("error: \(error)")
                }
                
                guard let result = json else { return }
                let entries = result.daily.data
                self.dailyModels.append(contentsOf: entries)
                
                let current = result.currently
                self.currentWeather = current
                self.hourlyModels = result.hourly.data
                self.conditionImage.image = UIImage(systemName: result.currently.conditionName)
                self.cityLabel.text = self.removeUnusedTextAndCharacters(result.timezone)
                self.summaryLabel.text = result.currently.summary
                
                
                self.table.reloadData()
                self.table.tableHeaderView = self.createTableHeader()
                self.table.tableFooterView = self.createTableFooter()
            }
        }.resume()
    }
    
    private func removeUnusedTextAndCharacters(_ text: String) -> String {
        
        var editedText = ""
        
        if let index = (text.range(of: "/")?.upperBound) {
            editedText = String(text.suffix(from: index))
            if editedText.contains("_") {
                editedText = editedText.replacingOccurrences(of: "_", with: " ")
                return editedText
            }
            return editedText
        }
        return text
    }
}
