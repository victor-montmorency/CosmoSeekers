//
//  HomeViewController.swift
//  CosmoSeekers
//
//  Created by victor mont-morency on 24/01/25.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    private let imageArray: [UIImage] = [UIImage(named: "nebula")!, UIImage(named: "Gasdwarf")!, UIImage(named: "exoplanets-1")!]
    private let labelArray: [String] = ["Nasa's Image of the day", "Exoplanets", "lorem"]
    
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupCollectionView()
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
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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
