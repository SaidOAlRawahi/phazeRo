//
//  Characters.swift
//  Marvel App
//
//  Created by Said Al Rawahi
//

import Foundation


struct CharacterData{ //this structure will be used only to store the required data for our view
    var characterID: Int
    var characterName: String
    var characterImageRef: String
    var characterWikiRef: String
}

struct CharacterResponse: Codable{
    //structuring the response from the get characters api call
    let code: Int
    let status: String
    let copyright: String
    let attributionText: String
    let attributionHTML: String
    let data: DATA // another structure is required for the data
    let etag: String
}

struct DATA: Codable{//DATA is capitalized to avoid conflicting with the @frozen struct Data
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Result] //another structure is required
}

struct Result: Codable{
    let id: Int
    let name: String
    let description: String
    let modified: String
    let resourceURI: String
    let urls: [URLs]
    let thumbnail: Thumbnail // another structure is required
    let comics: Comics
    let stories: Stories
    let events: Events
    let series: Series
}

struct URLs: Codable{
    var type: String
    var url: String
}

struct Thumbnail: Codable{
    let path: String
    let `extension`: String
}

struct Comics: Codable{
    var available: Int
    var returned: Int
    var collectionURI: String
    var items: [ComicItem]
}

struct ComicItem: Codable{
    var resourceURI: String
    var name: String
}

struct Stories: Codable{
    var available: Int
    var returned: Int
    var collectionURI: String
    var items: [StoriesItem]
}

struct StoriesItem: Codable{
    var resourceURI: String
    var name: String
    var type: String
}

struct Events: Codable{
    var available: Int
    var returned: Int
    var collectionURI: String
    var items: [EventsItem]
}

struct EventsItem: Codable{
    var resourceURI: String
    var name: String
}

struct Series: Codable{
    var available: Int
    var returned: Int
    var collectionURI: String
    var items: [SeriesItem]
}

struct SeriesItem: Codable{
    var resourceURI: String
    var name: String
}


/*
 the bellow is the structior of the response from the api call
{
    "code": "int",
    "status": "string",
    "copyright": "string",
    "attributionText": "string",
    "attributionHTML": "string",
    "data": {
        "offset": "int",
        "limit": "int",
        "total": "int",
        "count": "int",
        "results": [
            {
                "id": "int",
                "name": "string",
                "description": "string",
                "modified": "Date",
                "resourceURI": "string",
                "urls": [
                    {
                        "type": "string",
                        "url": "string"
                    }
                ],
                "thumbnail": {
                    "path": "string",
                    "extension": "string"
                },
                "comics": {
                    "available": "int",
                    "returned": "int",
                    "collectionURI": "string",
                    "items": [
                        {
                            "resourceURI": "string",
                            "name": "string"
                        }
                    ]
                },
                "stories": {
                    "available": "int",
                    "returned": "int",
                    "collectionURI": "string",
                    "items": [
                        {
                            "resourceURI": "string",
                            "name": "string",
                            "type": "string"
                        }
                    ]
                },
                "events": {
                    "available": "int",
                    "returned": "int",
                    "collectionURI": "string",
                    "items": [
                        {
                            "resourceURI": "string",
                            "name": "string"
                        }
                    ]
                },
                "series": {
                    "available": "int",
                    "returned": "int",
                    "collectionURI": "string",
                    "items": [
                        {
                            "resourceURI": "string",
                            "name": "string"
                        }
                    ]
                }
            }
        ]
    },
    "etag": "string"
}
*/
