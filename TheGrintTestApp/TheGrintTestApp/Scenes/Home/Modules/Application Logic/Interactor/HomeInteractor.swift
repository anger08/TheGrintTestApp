//
//  HomeInteractor.swift
//  TheGrintTestApp
//
//  Created by Angelber Castro on 4/4/24.
//

import Foundation

protocol HomeBusinessLogic {
    func getHomeTop(request: HomeModels.GetListTop.Request)
}
protocol HomeDataStore {}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomeTopPresentationLogic?
    var worker: HomeTopServiceProtocol

    init(worker: HomeTopServiceProtocol = HomeTopAPI()) {
        self.worker = worker
    }

    // MARK: - Methods
    func getHomeTop(request: HomeModels.GetListTop.Request) {
        worker.getHomeTop(request: request) { result in
            switch result {
            case .success(let response):
                self.presenter?.presentHomeTop(response: response)
            case .failure(let error):
                let response = HomeModels.Error.Response(error: error)
                self.presenter?.presentError(response: response)
            }
        }
    }
}
