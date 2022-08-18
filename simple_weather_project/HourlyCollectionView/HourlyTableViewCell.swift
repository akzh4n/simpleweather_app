//
//  HourlyTableViewCell.swift
//  simple_weather_project
//
//  Created by Акжан Калиматов on 17.08.2022.
//

import UIKit

class HourlyTableViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var hourlyModels = [HourlyWeatherEntry]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(
            WeatherCollectionViewCell.nib(), forCellWithReuseIdentifier: WeatherCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    static let identifier = "HourlyTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "HourlyTableViewCell", bundle: nil)
    }
    
    func configure(with model: [HourlyWeatherEntry]) {
        
        self.hourlyModels = model
        collectionView.reloadData()
    }
}

extension HourlyTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier,                                              for: indexPath) as! WeatherCollectionViewCell
        cell.configure(with: hourlyModels[indexPath.row])
        if indexPath.row == 0 {
            cell.timeLabel.text = "Now"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 100)
    }
}
