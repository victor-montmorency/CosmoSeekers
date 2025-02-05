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

struct SpaceflightResponse : Codable {
    let count : Int?
    let next : String?
    let previous : String?
    let results : [Results]?

    enum CodingKeys: String, CodingKey {

        case count = "count"
        case next = "next"
        case previous = "previous"
        case results = "results"
    }


}

struct Results : Codable {
    let id : Int?
    let title : String?
    let authors : [Authors]?
    let url : String?
    let image_url : String?
    let news_site : String?
    let summary : String?
    let published_at : String?
    let updated_at : String?
    let featured : Bool?
    let launches : [String]?
    let events : [String]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case authors = "authors"
        case url = "url"
        case image_url = "image_url"
        case news_site = "news_site"
        case summary = "summary"
        case published_at = "published_at"
        case updated_at = "updated_at"
        case featured = "featured"
        case launches = "launches"
        case events = "events"
    }


}

struct Authors : Codable {
    let name : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
    }


}
