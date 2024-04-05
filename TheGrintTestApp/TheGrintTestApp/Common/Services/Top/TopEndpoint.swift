//
//  TopEndpoint.swift
//  TheGrintTestApp
//
//  Created by Angelber Castro on 3/4/24.
//

import Alamofire

enum HomeEndpoint {
    case getHomeTop(query: String)
}

extension HomeEndpoint: IEndpoint {
    var method: HTTPMethod {
        switch self {
        case .getHomeTop:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getHomeTop(query: let query):
            return "\(query)/top?/limit=\(20)"
        }
    }

    var parameter: Parameters? {
        switch self {
        case .getHomeTop:
            return nil
        }
    }

    var header: HTTPHeaders? {
        switch self {
        case .getHomeTop:
            return nil
        }
    }

    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
