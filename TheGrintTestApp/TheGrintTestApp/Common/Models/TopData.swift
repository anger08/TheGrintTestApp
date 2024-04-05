//
//  TopData.swift
//  TheGrintTestApp
//
//  Created by Angelber Castro on 4/4/24.
//

import Foundation

struct RedditTopData: Codable {
    let after: String?
    let dist: Int
    let geoFilter: String
    let children: [TopChildren]
    let before: String?

    enum CodingKeys: String, CodingKey {
        case after
        case dist
        case geoFilter = "geo_filter"
        case children
        case before
    }
}

struct TopChildren: Codable {
    let kind: String
    let data: RedditPostData
}

struct RedditPostData: Codable {
    let author: String
    let subreddit: String
    let selfText: String
    let title: String
    let subredditNamePrefixed: String
    let name: String
    let ups: Int
    let numComments: Int
    let media: Media?

    enum CodingKeys: String, CodingKey {
        case subreddit
        case selfText = "selftext"
        case title
        case subredditNamePrefixed = "subreddit_name_prefixed"
        case name
        case ups
        case author
        case numComments = "num_comments"
        case media = "media"
    }
}

struct Media: Codable {
    let oembed: Oembed?

    enum CodingKeys: String, CodingKey {
        case oembed
    }
}

struct Oembed: Codable {
    let thumbnailUrl: String?

    enum CodingKeys: String, CodingKey {
        case thumbnailUrl = "thumbnail_url"
    }
}
