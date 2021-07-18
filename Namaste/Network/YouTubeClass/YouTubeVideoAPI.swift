//
//  YouTubeVideoAPI.swift
//  Namaste
//
//  Created by Vladyslav Prosianyk on 25.05.2021.
//

import Foundation

struct YouTubeVideo: Codable {
    let kind: String?
    let etag: String?
    let nextPageToken: String?
    let regionCode: String?
    let pageInfo: PageInfo
    let items: [Item]

    enum CodingKeys: String, CodingKey {
        case kind
        case etag
        case nextPageToken
        case regionCode
        case pageInfo
        case items
    }
}

struct Item: Codable {
    let kind: String?
    let etag: String?
    let id: ID
    let snippet: Snippet

    enum CodingKeys: String, CodingKey {
        case kind
        case etag
        case id
        case snippet
    }
}

struct ID: Codable {
    let kind: String?
    let videoId: String?

    enum CodingKeys: String, CodingKey {
        case kind
        case videoId = "videoId"
    }
}

struct Snippet: Codable {
    let publishedAt: String?
    let channelId: String?
    let title: String?
    let description: String?
    let thumbnails: Thumbnails
    let channelTitle: String?
    let liveBroadcastContent: String?
    let publishTime: String?

    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelId
        case title
        case description
        case thumbnails
        case channelTitle
        case liveBroadcastContent
        case publishTime
    }
}

struct Thumbnails: Codable {
    let `default`: Default
    let medium: Default
    let high: Default

    enum CodingKeys: String, CodingKey {
        case `default`
        case medium
        case high
    }
}

struct Default: Codable {
    let url: String?
    let width: Int?
    let height: Int?

    enum CodingKeys: String, CodingKey {
        case url
        case width
        case height
    }
}

struct PageInfo: Codable {
    let totalResults: Int?
    let resultsPerPage: Int?

    enum CodingKeys: String, CodingKey {
        case totalResults
        case resultsPerPage
    }
}
