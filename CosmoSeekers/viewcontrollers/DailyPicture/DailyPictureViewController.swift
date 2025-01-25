//
//  DailyPictureViewController.swift
//  CosmoSeekers
//
//  Created by victor mont-morency on 24/01/25.
//

import UIKit
import Alamofire

class DailyPictureViewController: UIViewController {
    
    var imageView = UIImageView()
    var copyrightLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLoadingIndicator()
        getNasaData()
        setLayout()
        
        
    }
    
    func setLayout() {

        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        view.addSubview(imageView)

        copyrightLabel.translatesAutoresizingMaskIntoConstraints = false
        copyrightLabel.numberOfLines = 0
        copyrightLabel.lineBreakMode = .byWordWrapping
        copyrightLabel.textAlignment = .center
        view.addSubview(copyrightLabel)

        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor),

            
           copyrightLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            copyrightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            copyrightLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            copyrightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)

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
                 let copyright = response.value?.copyright ?? ""
                 let title = response.value?.title ?? ""
                 let date = response.value?.date ?? ""
                 //let explanation = response.value?.explanation ?? ""



                 AF.download(url).responseData { response in
                             if let data = response.value {
                                 self.imageView.image = UIImage(data: data)
                             }
                     self.hideLoadingIndicator()
                             }
                 self.copyrightLabel.text = "'\(title)'\nby \(copyright)\n\(date)\n"
                 debugPrint(copyright)


             case .failure:
                 debugPrint(response.error?.localizedDescription ?? "")
             }
         }
        }
    
}
