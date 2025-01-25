//
//  ExoplanetsTableViewCell.swift
//  CosmoSeekers
//
//  Created by victor mont-morency on 25/01/25.
//

import UIKit

class ExoplanetsTableViewCell: UITableViewCell {

    let plNameLabel = UILabel()
    let discFacilityLabel = UILabel()
    let discoverymethodLabel = UILabel()
    let discYearLabel = UILabel()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        
    }
    
    private func setLayout(){
        plNameLabel.translatesAutoresizingMaskIntoConstraints = false
        plNameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        contentView.addSubview(plNameLabel)
        discFacilityLabel.translatesAutoresizingMaskIntoConstraints = false
        discFacilityLabel.font = .systemFont(ofSize: 14)
        contentView.addSubview(discFacilityLabel)
        discoverymethodLabel.translatesAutoresizingMaskIntoConstraints = false
        discoverymethodLabel.font = .systemFont(ofSize: 14)
        contentView.addSubview(discoverymethodLabel)
        discYearLabel.translatesAutoresizingMaskIntoConstraints = false
        discYearLabel.font = .systemFont(ofSize: 14)
        contentView.addSubview(discYearLabel)
        
        NSLayoutConstraint.activate([
            plNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            plNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            discYearLabel.leadingAnchor.constraint(equalTo: plNameLabel.trailingAnchor),
            discYearLabel.topAnchor.constraint(equalTo: plNameLabel.topAnchor),
            discoverymethodLabel.topAnchor.constraint(equalTo: plNameLabel.bottomAnchor, constant: 20),
            discoverymethodLabel.leadingAnchor.constraint(equalTo: plNameLabel.leadingAnchor),
            discFacilityLabel.topAnchor.constraint(equalTo: discoverymethodLabel.bottomAnchor, constant: 20),
            discFacilityLabel.leadingAnchor.constraint(equalTo: plNameLabel.leadingAnchor)
            
        ])
    }
    
    func configure(with exoplanet: exoplanetarchiveResponse){
        plNameLabel.text = exoplanet.pl_name
        discoverymethodLabel.text = exoplanet.discoverymethod
        discYearLabel.text = String(exoplanet.disc_year)
        discFacilityLabel.text = exoplanet.disc_facility
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
