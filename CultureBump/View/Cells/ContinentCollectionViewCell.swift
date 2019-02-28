//
//  CountryCollectionViewCell.swift
//  CultureBump
//
//  Created by renameme on 2/8/19.
//  Copyright © 2019 Auburn. All rights reserved.
//

import UIKit

class CountryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var flag: UIImageView!
    @IBOutlet weak var continentName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureCell()
    }
    
    private func configureCell() {
        self.layer.cornerRadius = 6.0
        self.layer.masksToBounds = true
        
        self.layer.shadowColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 0.1782903741)
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 20
        self.layer.masksToBounds = false
        
    }
    
    func setData(continent : Continent){
        continentName.text = continent.continent_name
        print("\(continent.continent_name!).png")
        flag.image = UIImage(named: "\(continent.continent_name!).png")
        self.backgroundColor = continent.continent_background_color!.hexStringToUIColor()
    }

}
