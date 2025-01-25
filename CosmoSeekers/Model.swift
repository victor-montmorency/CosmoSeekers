//
//  Model.swift
//  CosmoSeekers
//
//  Created by victor mont-morency on 25/01/25.
//
import Foundation

struct exoplanetarchiveResponse: Decodable {
    let pl_name, disc_facility,discoverymethod: String
    let disc_year: Int
    
}
struct Response: Codable {
    let countPlName: Int

    // Define a custom coding key
    private enum CodingKeys: String, CodingKey {
        case countPlName = "count(pl_name)"
    }
}
struct NasaPODResponse: Decodable {
    let url, explanation, copyright, title, date: String
}
