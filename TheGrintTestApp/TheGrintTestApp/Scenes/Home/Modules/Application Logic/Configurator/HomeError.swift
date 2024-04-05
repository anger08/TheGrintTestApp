//
//  HomeError.swift
//  TheGrintTestApp
//
//  Created by Angelber Castro on 4/4/24.
//

import Foundation

enum HomeError: Error, CustomStringConvertible {
    case request
    case network(Error)
    case parse(Error)
    case server(description: String)

    var description: String {
        switch self {
        case .network(let error), .parse(let error):
            return error.localizedDescription
        case .request:
            return "Error"
        case .server(let description):
            return description
        }
    }
}
