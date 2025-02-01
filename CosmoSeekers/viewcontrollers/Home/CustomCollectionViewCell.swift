//
//  CustomCollectionViewCell.swift
//  CosmoSeekers
//
//  Created by victor mont-morency on 01/02/25.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    private let backgroundImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()

    private let label: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()


    func configure(text: String, image: UIImage?) {
        label.text = text
        backgroundImage.image = image
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true

        // Add background image first
        contentView.addSubview(backgroundImage)
        contentView.addSubview(label)

        NSLayoutConstraint.activate([
            // Background image fills entire cell
            backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            // Label centered on top of the image
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
