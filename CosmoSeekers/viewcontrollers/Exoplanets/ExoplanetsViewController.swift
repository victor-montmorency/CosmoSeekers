//
//  ExoplanetsViewController.swift
//  CosmoSeekers
//
//  Created by victor mont-morency on 25/01/25.
//

import UIKit
import Alamofire

class ExoplanetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tableView: UITableView!
    var exoplanets: [exoplanetarchiveResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingIndicator()
        getLast20DiscoveredPlanetsInfo()
        setupUI()
    }
    
    func setupUI(){
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ExoplanetsTableViewCell.self, forCellReuseIdentifier: "ExoplanetsTableViewCell")
        tableView.rowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.heightAnchor.constraint(equalToConstant: 400),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    var loadingIndicator: UIActivityIndicatorView!

    private func setupLoadingIndicator() {
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
    
     func getLast20DiscoveredPlanetsInfo() {
        showLoadingIndicator()
        let urlString = "https://exoplanetarchive.ipac.caltech.edu/TAP/sync?query=select+distinct(pl_name),disc_year,disc_facility,discoverymethod+from+ps+order+by+disc_year+desc&format=json"
        
         AF.request(URL(string: urlString)!).responseDecodable(of: [exoplanetarchiveResponse].self) { response in
             DispatchQueue.main.async {
                 switch response.result {
                 case .success(let planets):
                     let top20Planets = planets.prefix(20)
                     for planet in top20Planets{
                         self.exoplanets.append(planet)
                     }
                     self.tableView.reloadData()
                     print(top20Planets)
                     
                 case .failure:
                     debugPrint(response.error?.localizedDescription ?? "")
                 }
                 self.hideLoadingIndicator()
             }
         }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exoplanets.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExoplanetsTableViewCell", for: indexPath) as! ExoplanetsTableViewCell
            let data = exoplanets[indexPath.row]
        cell.configure(with: data)
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Last 20 discovered exoplanets"
    }

    
     func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textAlignment = .center
            header.textLabel?.textColor = .darkGray
        }
    }

}
