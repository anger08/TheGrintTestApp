//
//  HomeModels.swift
//  TheGrintTestApp
//
//  Created by Angelber Castro on 4/4/24.
//

import Foundation

enum HomeModels {
    enum GetListTop {
        struct Request: Codable {
            let query : String
            let limit : Int
        }

        struct Response: Codable {
            let kind: String
            let data: RedditTopData

            enum CodingKeys: String, CodingKey {
                case data
                case kind

            }
        }

        struct ViewModel {
            let data: RedditTopData
        }
    }

    enum Error {
        struct Request {}
        struct Response {
            var error: HomeError
        }
        struct ViewModel {
            var error: HomeError
        }
    }
}
