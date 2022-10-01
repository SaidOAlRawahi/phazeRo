//
//  Comics.swift
//  Marvel App
//
//  Created by Said Al Rawahi
//

import Foundation


struct ComicsData{ //this structure will be used only to store the required data for our view
    var comicName: String
    var comicImageRef: String
    var comicWikiRef: String
}

struct ComicsResponse: Codable{
    //structuring the response from the get characters api call
    let code: Int
    let status: String
    let copyright: String
    let attributionText: String
    let attributionHTML: String
    let data: ComicsDATA // another structure is required for the data
    let etag: String
}

struct ComicsDATA: Codable{//DATA is capitalized to distinguish it from the ComicsData
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [ComicsResult] //another structure is required
}

struct ComicsResult: Codable{
    let id: Int
    let digitalId: Int
    let title: String
    let issueNumber: Double
    let variantDescription: String
    //let description: String  //commented to avoid issues with decoding for sme characters
    let modified: String
    let isbn: String
    let upc: String
    let diamondCode: String
    let ean: String
    let issn: String
    let format: String
    let pageCount: Int
    let textObjects: [TextObject]
    let resourceURI: String
    let urls: [Url]
    let series: ComicSeries
    let variants: [Varient]
    let collections: [Collection]
    let collectedIssues: [CollectedIssue]
    let dates: [ComicDate]
    let prices: [Price]
    let thumbnail: ComicThumbnail
    let images: [ComicImage]
    let creators: Creators
    let characters: Characters
    let stories: ComicStories
    let events: ComicEvent
}

struct ComicEvent: Codable{
    let available: Int
    let returned: Int
    let collectionURI: String
    let items: [ITEM]
}

struct ITEM: Codable{
    let name: String
    let resourceURI: String
}

struct ComicStories: Codable{
    let available: Int
    let returned: Int
    let collectionURI: String
    let items: [Item]
}

struct Item: Codable{
    let name: String
    let type: String
    let resourceURI: String
}

struct Characters: Codable{
    let available: Int
    let returned: Int
    let collectionURI: String
    let items: [CharacterItem]
}

struct CharacterItem: Codable{
    let name: String
    //let role: String  //commented to avoid issues with decoding for sme characters
    let resourceURI: String
}

struct Creators: Codable{
    let available: Int
    let returned: Int
    let collectionURI: String
    let items: [CreatorItem]
}

struct CreatorItem: Codable{
    let name: String
    let role: String
    let resourceURI: String
}

struct ComicImage: Codable{
    let path: String
    let `extension`: String
}

struct ComicThumbnail: Codable{
    let path: String
    let `extension`: String
}

struct Price:Codable{
    let type: String
    let price: Float
}

struct ComicDate: Codable{
    let type: String
    let date: String
}

struct CollectedIssue: Codable{
    let resourceURI: String
    let name: String
}

struct Collection: Codable{
    let resourceURI: String
    let name: String
}

struct Varient: Codable{
    let resourceURI: String
    let name: String
}

struct ComicSeries: Codable{
    let resourceURI: String
    let name: String
}

struct Url: Codable{
    let type: String
    let url: String
}

struct TextObject: Codable{
    let type: String
    let language: String
    let text: String
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
                "digitalId": "int",
                "title": "string",
                "issueNumber": "double",
                "variantDescription": "string",
                "description": "string",
                "modified": "Date",
                "isbn": "string",
                "upc": "string",
                "diamondCode": "string",
                "ean": "string",
                "issn": "string",
                "format": "string",
                "pageCount": "int",
                "textObjects": [
                    {
                        "type": "string",
                        "language": "string",
                        "text": "string"
                    }
                ],
                "resourceURI": "string",
                "urls": [
                    {
                        "type": "string",
                        "url": "string"
                    }
                ],
                "series": {
                    "resourceURI": "string",
                    "name": "string"
                },
                "variants": [
                    {
                        "resourceURI": "string",
                        "name": "string"
                    }
                ],
                "collections": [
                    {
                        "resourceURI": "string",
                        "name": "string"
                    }
                ],
                "collectedIssues": [
                    {
                        "resourceURI": "string",
                        "name": "string"
                    }
                ],
                "dates": [
                    {
                        "type": "string",
                        "date": "Date"
                    }
                ],
                "prices": [
                    {
                        "type": "string",
                        "price": "float"
                    }
                ],
                "thumbnail": {
                    "path": "string",
                    "extension": "string"
                },
                "images": [
                    {
                        "path": "string",
                        "extension": "string"
                    }
                ],
                "creators": {
                    "available": "int",
                    "returned": "int",
                    "collectionURI": "string",
                    "items": [
                        {
                            "resourceURI": "string",
                            "name": "string",
                            "role": "string"
                        }
                    ]
                },
                "characters": {
                    "available": "int",
                    "returned": "int",
                    "collectionURI": "string",
                    "items": [
                        {
                            "resourceURI": "string",
                            "name": "string",
                            "role": "string"
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
                }
            }
        ]
    },
    "etag": "string"
}
*/
