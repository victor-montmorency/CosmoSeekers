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
            plNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            plNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            discFacilityLabel.topAnchor.constraint(equalTo: plNameLabel.bottomAnchor),
            discFacilityLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            discYearLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            discYearLabel.topAnchor.constraint(equalTo: discFacilityLabel.bottomAnchor),
            discoverymethodLabel.topAnchor.constraint(equalTo: discYearLabel.topAnchor),
            discoverymethodLabel.leadingAnchor.constraint(equalTo: discYearLabel.trailingAnchor),

            
        ])
    }
    
    func configure(with exoplanet: exoplanetarchiveResponse){
        plNameLabel.text = exoplanet.pl_name
        discoverymethodLabel.text = "using \(exoplanet.discoverymethod) method"
        let discYear = String(exoplanet.disc_year)
        discYearLabel.text = "in \(discYear)"
        discFacilityLabel.text = "discovered by \(exoplanet.disc_facility)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
