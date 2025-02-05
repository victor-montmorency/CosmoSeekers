//
//  HomeViewController.swift
//  CosmoSeekers
//
//  Created by victor mont-morency on 24/01/25.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    private let imageArray: [UIImage] = [UIImage(named: "nebula")!, UIImage(named: "Gasdwarf")!, UIImage(named: "exoplanets-1")!]
    private let labelArray: [String] = ["Nasa's Image of the day", "Exoplanets", "lorem"]
    let scrollView = UIScrollView()
    let contentView = UIView()
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setScrollView()
        setupCollectionView()
        setupNewsSection()
        spaceFlightsAF()
    }
    
    private func setScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        
        
        
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
    }
    
    func spaceFlightsAF(){

    }
    
    func setupNewsSection() {
        
        var newsViewArray: [NewsView] = []
        
        for _ in 0...2 {
            newsViewArray.append(NewsView(frame: .zero, image: UIImage(named: "placeholderImage")!, headline: ""))
        }
        
        for newsView in newsViewArray {
            contentView.addSubview(newsView)
            newsView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let newsSectionTitle = UILabel()
        contentView.addSubview(newsSectionTitle)

        
        AF.request(URL(string: "https://api.spaceflightnewsapi.net/v4/articles/?limit=3&offset=3")!).responseDecodable(of: SpaceflightResponse.self) {
            response in
            print(response)
            switch response.result {
            case .success:
                newsViewArray[0].newsHeadline.text = response.value?.results?[0].title
                newsViewArray[1].newsHeadline.text = response.value?.results?[1].title
                newsViewArray[2].newsHeadline.text = response.value?.results?[2].title
                
                
                for (index,newsView) in newsViewArray.enumerated() {
                    AF.download(URL(string: response.value?.results?[index].image_url ?? "")!).responseData { response in
                        if let data = response.value {
                            let img = UIImage(data: data)
                            newsView.newsImage.image = img
                        }
                    }
                }
                
                
                default :
                print("error")
            }
       
        }
        
        
        
        newsSectionTitle.text = "Recent Spaceflight News"
        newsSectionTitle.textColor = .label
        newsSectionTitle.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        newsSectionTitle.textColor = .label
        newsSectionTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsSectionTitle.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 32),
            newsSectionTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            newsViewArray[0].topAnchor.constraint(equalTo: newsSectionTitle.bottomAnchor),
            newsViewArray[0].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            newsViewArray[0].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            newsViewArray[0].heightAnchor.constraint(equalToConstant: 300),
            
            newsViewArray[1].topAnchor.constraint(equalTo: newsViewArray[0].bottomAnchor, constant: 16),
            newsViewArray[1].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            newsViewArray[1].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            newsViewArray[1].heightAnchor.constraint(equalToConstant: 300),
            
            newsViewArray[2].topAnchor.constraint(equalTo: newsViewArray[1].bottomAnchor, constant: 16),
            newsViewArray[2].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            newsViewArray[2].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            newsViewArray[2].heightAnchor.constraint(equalToConstant: 300),
            newsViewArray[2].bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
    }

    func setupCollectionView() {
        let label = UILabel()
        label.text = "From NASA"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .label
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // Create a flow layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal  // Set scroll direction to horizontal
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(width: 150, height: 188) // Size of each cell
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10) // Adds 20pt spacing to the left

        // Initialize Collection View
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        // Register Cell
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        // Set Delegates
        collectionView.delegate = self
        collectionView.dataSource = self

        // Add to View
        view.addSubview(collectionView)

        // Constraints
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 50),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 188)
        ])
    }

    // MARK: UICollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3 // Number of items
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        cell.configure(text: labelArray[indexPath.item], image: imageArray[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath {
        case IndexPath(item: 0, section: 0):
            navigationController?.pushViewController(DailyPictureViewController(), animated: true)

        case IndexPath(item: 1, section: 0):
            navigationController?.pushViewController(ExoplanetsViewController(), animated: true)
        default:
            break
        }
    }
}
