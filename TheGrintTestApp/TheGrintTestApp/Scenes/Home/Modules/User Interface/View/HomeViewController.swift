//
//  HomeViewController.swift
//  TheGrintTestApp
//
//  Created by Angelber Castro on 4/4/24.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayHomeTop(viewModel: HomeModels.GetListTop.ViewModel, on queu: DispatchQueue)
    func displayError(viewModel: HomeModels.Error.ViewModel, on queu: DispatchQueue)
}

class HomeViewController: BaseViewController, UITextFieldDelegate {
    @IBOutlet weak var homeSearchTextField: UITextField!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    var redditChild: [TopChildren] = []
    var cellHomeCollectionNibName = "HomeCollectionViewCell"

    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?


    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        settingsNavBarImage()
        settingsCollectionView()
        getHomeTop(query: "messi", page: 20)

        homeSearchTextField.delegate = self
    }

    func settingsCollectionView() {
        homeCollectionView.register(UINib(nibName: self.cellHomeCollectionNibName, bundle: nil),
                                         forCellWithReuseIdentifier: HomeCollectionViewCell.reuseIdentifier)

        homeCollectionView.layer.cornerRadius = 30
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.redditChild.removeAll()
        configSearch()
        view.endEditing(true)
        return false
    }

    func configSearch() {
        if let text = homeSearchTextField?.text?.lowercased() {
            self.getHomeTop(query: text, page: 20)
        }
    }

    func getHomeTop(query: String, page: Int) {
        let request = HomeModels.GetListTop.Request(query: query, limit: page)
        interactor?.getHomeTop(request: request)
    }
}

extension HomeViewController: HomeDisplayLogic {
    func displayHomeTop(viewModel: HomeModels.GetListTop.ViewModel, on queu: DispatchQueue) {
        self.redditChild = viewModel.data.children
        self.homeCollectionView.reloadData()

        print("\(redditChild.count)")
    }

    func displayError(viewModel: HomeModels.Error.ViewModel, on queu: DispatchQueue = .main) {
        displaySimpleAlert(with: "Error", message: "Elementos no disponibles, intente de nuevo")
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return redditChild.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.reuseIdentifier, for: indexPath) as? HomeCollectionViewCell else {
                fatalError()
            }
            let response = redditChild[indexPath.row]
            cell.configUI(top: response)

            return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailTopViewController()
        vc.detailDt = self.redditChild[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 390, height: 150)
    }
}
