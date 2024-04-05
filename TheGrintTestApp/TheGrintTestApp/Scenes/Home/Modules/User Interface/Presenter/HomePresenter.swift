//
//  HomePresenter.swift
//  TheGrintTestApp
//
//  Created by Angelber Castro on 4/4/24.
//

protocol HomeTopPresentationLogic {
    func presentHomeTop(response: HomeModels.GetListTop.Response)
    func presentError(response: HomeModels.Error.Response)
}

class HomePresenter: HomeTopPresentationLogic {
    weak var viewController: HomeDisplayLogic?

    // MARK: - Present-Home-Top
    func presentHomeTop(response: HomeModels.GetListTop.Response) {
        let viewModel = HomeModels.GetListTop.ViewModel(data: response.data)
        viewController?.displayHomeTop(viewModel: viewModel, on: .main)
    }

    func presentError(response: HomeModels.Error.Response) {
        let viewModel = HomeModels.Error.ViewModel(error: response.error)
        viewController?.displayError(viewModel: viewModel, on: .main)
    }
}
