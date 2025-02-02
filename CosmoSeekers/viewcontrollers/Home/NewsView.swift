//
//  NewsView.swift
//  CosmoSeekers
//
//  Created by victor mont-morency on 01/02/25.
//

import UIKit

class NewsView: UIView {

    var newsImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        addSubview(newsImage)
        newsImage.image = UIImage(named: "nebula")

        newsImage.translatesAutoresizingMaskIntoConstraints = false
        newsImage.contentMode = .scaleToFill
        
        NSLayoutConstraint.activate([
            newsImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            newsImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            newsImage.heightAnchor.constraint(equalToConstant: 200),

            newsImage.widthAnchor.constraint(equalTo: self.widthAnchor)


        ])
    }
}
#Preview {
    return NewsView()
}
