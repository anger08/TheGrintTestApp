//
//  HomeTopAPI.swift
//  TheGrintTestApp
//
//  Created by Angelber Castro on 4/4/24.
//

import Foundation

// MARK: - PostsServiceProtocol
protocol HomeTopServiceProtocol {
    func getHomeTop(request: HomeModels.GetListTop.Request, completion: @escaping (Result<HomeModels.GetListTop.Response, HomeError>) -> Void)
}

// MARK: - PostsAPI
class HomeTopAPI: HomeTopServiceProtocol {
    func getHomeTop(request: HomeModels.GetListTop.Request, completion: @escaping (Result<HomeModels.GetListTop.Response, HomeError>) -> Void) {

        NetworkService.share.request(endpoint: HomeEndpoint.getHomeTop(query: request.query)) { result in
            switch result {
            case .success:
                do {
                    let data = try result.get()
                    let response = try JSONDecoder().decode(HomeModels.GetListTop.Response.self, from: data!)
                    completion(.success(response))
                } catch let error {
                    completion(.failure(.parse(error)))
                }
            case .failure(let error):
                completion(.failure(.network(error)))
            }
        }
    }
}
