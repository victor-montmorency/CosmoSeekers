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
struct NasaPODResponse: Decodable {
    let url, explanation, copyright, title, date: String
}
