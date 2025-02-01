//
//  ExoplanetsViewController.swift
//  CosmoSeekers
//
//  Created by victor mont-morency on 25/01/25.
//

import UIKit
import Alamofire

class ExoplanetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var countLabel = UILabel()
    var tableView: UITableView!
    var exoplanets: [exoplanetarchiveResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingIndicator()
        setupUI()
        getLast20DiscoveredPlanetsInfo()
        getTotalCountExoplanets()
    }
    
    func setupUI(){
        tableView = UITableView(frame: view.safeAreaLayoutGuide.layoutFrame, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ExoplanetsTableViewCell.self, forCellReuseIdentifier: "ExoplanetsTableViewCell")
        tableView.rowHeight = 60
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(countLabel)
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            countLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            countLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: countLabel.bottomAnchor),
            tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor)
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
    
    func getTotalCountExoplanets(){
        let urlString = "https://exoplanetarchive.ipac.caltech.edu/TAP/sync?query=select+count(pl_name)+from+ps+where+default_flag=1&format=json"
        AF.request(URL(string: urlString)!).responseDecodable(of: [Response].self){
            response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let test):
                    let numberOfPlanets = String(test[0].countPlName)
                    self.countLabel.text = "Já foram descobertos \(numberOfPlanets) exoplanetas!!!"
                    print(numberOfPlanets)
                case .failure:
                    debugPrint(response.error?.localizedDescription ?? "")
                }
            }
        }
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
    
     func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textAlignment = .center
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Last discovered exoplanets"
    }


}
