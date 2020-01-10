//
//  NewsHeadline.swift
//  TopStories
//
//  Created by Oscar Victoria Gonzalez  on 11/25/19.
//  Copyright © 2019 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation

// top level JSON - HeadlinesData.self because top level JSON is a dictionary
struct HeadlinesData: Codable {
    let results: [NewsHeadline] // "results represents the JSON array of stories"
}


struct NewsHeadline: Codable {
    let title: String
    let abstract: String
    let byline: String
    let multimedia: [Multimedia]
}

struct Multimedia: Codable {
    let url: String
    let caption: String
    let format: String // "thumbLarge" "superJumbo"
}
    
 extension NewsHeadline {
    var thumbImage: Multimedia? {
        return multimedia.filter { $0.format == "thumbLarge"}.first // 150 x 150
    }
    var superJumbo : Multimedia? {
        return multimedia.filter { $0.format == "superJumbo"}.first // 1080 x 2080
    }
}


extension HeadlinesData {
    // parse the "topStoriesTechnology.json" into array of [NewsHeadline] objects
    static func getHeadlines() -> [NewsHeadline] {
        var headlines = [NewsHeadline]()
        
        // The app Bundle() allows to access (read) our app resources and files, e.g mp3 file or in our case the topStoriesTechnology.json
        // here we need the url to the topStoriesTechnology.json file
        guard let fileURL = Bundle.main.url(forResource: "topStoriesTechnology", withExtension: "json") else {
            fatalError("could not locate json file")
        }
        // get data from the contents of the fileURL
        do {
            let data = try Data(contentsOf: fileURL)
            // Parse data to our Swift [NewHeadline]
            
            let headlinesData = try JSONDecoder().decode(HeadlinesData.self, from: data)
            headlines = headlinesData.results
        } catch {
            print("Failed to load contents \(error)")
        }
        
        
        return headlines
    }
}
