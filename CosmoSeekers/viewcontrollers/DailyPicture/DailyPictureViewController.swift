//
//  DailyPictureViewController.swift
//  CosmoSeekers
//
//  Created by victor mont-morency on 24/01/25.
//

import UIKit
import Alamofire

class DailyPictureViewController: UIViewController {
    var ratio: CGFloat = 1.0
    let scrollView = UIScrollView()
    let contentView = UIView()
    let imageView = UIImageView()
    let imageGivenName = UILabel()
    let authorName = UILabel()
    let dateLabel = UILabel()
    let explanationLabel = UILabel()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Nasa's Image of the day"
        view.backgroundColor = .systemBackground
        setupLoadingIndicator()
        getNasaData()
//        setLayout()
        setScrollView()
    }
    
    private func setScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        
        self.scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let hConst = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        hConst.isActive = true
        hConst.priority = UILayoutPriority(50)

        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

        ])
        configureLayout()
    }
    
    private func configureLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        imageGivenName.translatesAutoresizingMaskIntoConstraints = false
        imageGivenName.numberOfLines = 0
        imageGivenName.lineBreakMode = .byWordWrapping
        imageGivenName.textAlignment = .center
        imageGivenName.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        contentView.addSubview(imageGivenName)
        
        authorName.translatesAutoresizingMaskIntoConstraints = false
        authorName.numberOfLines = 0
        authorName.lineBreakMode = .byWordWrapping
        authorName.textAlignment = .center
        authorName.font = UIFont.preferredFont(forTextStyle: .title3)
        contentView.addSubview(authorName)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.numberOfLines = 0
        dateLabel.lineBreakMode = .byWordWrapping
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        contentView.addSubview(dateLabel)

        explanationLabel.translatesAutoresizingMaskIntoConstraints = false
        explanationLabel.numberOfLines = 0
        explanationLabel.lineBreakMode = .byWordWrapping
        explanationLabel.textAlignment = .center
        explanationLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        contentView.addSubview(explanationLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            imageGivenName.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            imageGivenName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageGivenName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageGivenName.centerYAnchor.constraint(equalTo: imageGivenName.centerYAnchor),

            
            authorName.topAnchor.constraint(equalTo: imageGivenName.bottomAnchor),
            authorName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            authorName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            
            dateLabel.topAnchor.constraint(equalTo: authorName.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            explanationLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 40),
            explanationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            explanationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            explanationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
            

            ])
    }

    var loadingIndicator: UIActivityIndicatorView!

    func setupLoadingIndicator() {
        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.center = view.center
        loadingIndicator.hidesWhenStopped = true
        view.addSubview(loadingIndicator)
    }
    
    func showLoadingIndicator() {
        loadingIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }

    func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
    }
    
    
    func getNasaData() {
        showLoadingIndicator()
         AF.request(URL(string: "https://api.nasa.gov/planetary/apod?api_key=BB09b87UySqt1CmhyAkMJcEciQsaTzwC6YdGcNBa")!).responseDecodable(of: NasaPODResponse.self) { response in
             
             switch response.result {
             case .success:
                 
                 let url = response.value?.url ?? ""
                 let copyright = response.value?.copyright.replacingOccurrences(of: "\n", with: "") ?? ""
                 debugPrint(copyright)
                 let title = response.value?.title ?? ""
                 let date = response.value?.date ?? ""
                 let explanation = response.value?.explanation ?? ""
                 


                 AF.download(url).responseData { response in
                             if let data = response.value {
                                 let img = UIImage(data: data)
                                 self.imageView.image = img
                             }
                     self.ratio = ((self.imageView.image?.size.width)!/(self.imageView.image?.size.height)!)
                     NSLayoutConstraint.activate([
                        self.imageView.heightAnchor.constraint(equalToConstant: self.view.frame.width/self.ratio),
                     ])
                     self.hideLoadingIndicator()

                     self.view.setNeedsLayout()


                             }
                 self.imageGivenName.text = title
                 
                 self.authorName.text = copyright
                 self.dateLabel.text = date
                 self.explanationLabel.text = explanation



             case .failure:
                 debugPrint(response.error?.localizedDescription ?? "")
             }
         }
        }
    
}
