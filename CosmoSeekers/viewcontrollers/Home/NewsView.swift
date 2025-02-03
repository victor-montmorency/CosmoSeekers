//
//  NewsView.swift
//  CosmoSeekers
//
//  Created by victor mont-morency on 01/02/25.
//

import UIKit


class NewsView: UIView {

    var newsImage = UIImageView()
    var newsHeadline = UILabel()
    private let arrowImage = UIImageView()
    
     init(frame: CGRect, image: UIImage, headline: String) {
        super.init(frame: frame)
        newsImage.image = image
        newsHeadline.text = headline
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        addSubview(newsImage)
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        newsImage.contentMode = .scaleToFill
        
        newsHeadline.numberOfLines = 2
        addSubview(newsHeadline)
        newsHeadline.translatesAutoresizingMaskIntoConstraints = false
        newsHeadline.font = UIFont.preferredFont(forTextStyle: .headline)
        newsHeadline.lineBreakMode = .byTruncatingTail
        newsHeadline.backgroundColor = .systemBlue
        newsHeadline.textColor = .white
        
        addSubview(arrowImage)
        arrowImage.image = UIImage(systemName: "arrow.forward.circle.fill")
        arrowImage.translatesAutoresizingMaskIntoConstraints = false
        arrowImage.contentMode = .scaleAspectFit
        arrowImage.tintColor = .systemBlue
        arrowImage.preferredSymbolConfiguration = .preferringMulticolor()
        
        NSLayoutConstraint.activate([
            newsImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            newsImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            newsImage.heightAnchor.constraint(equalToConstant: 300),

            newsImage.widthAnchor.constraint(equalTo: self.widthAnchor),
            newsHeadline.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: -70),
            newsHeadline.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -80),
            newsHeadline.leadingAnchor.constraint(equalTo: newsImage.leadingAnchor),
            
            arrowImage.topAnchor.constraint(equalTo: newsHeadline.topAnchor),
            arrowImage.bottomAnchor.constraint(equalTo: newsHeadline.bottomAnchor),
            arrowImage.leadingAnchor.constraint(equalTo: newsHeadline.trailingAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: newsImage.trailingAnchor),

        ])
    }
}

