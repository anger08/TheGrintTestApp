//
//  BaseViewController.swift
//  TheGrintTestApp
//
//  Created by Angelber Castro on 4/4/24.
//

import UIKit

class BaseViewController: UIViewController {
    let titleView = UIView(frame: CGRect(x: -175, y: 0, width: 165, height: 40))
    var isActiveMenu: Bool = false
    var searchActivePayment: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }

    func hideBackButton() {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }

    func setupBackButton() {
        let backButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"),
                                                              style: .plain,
                                                              target: self,
                                                              action: #selector(self.backButtonClickedDismiss(sender:)))

        self.navigationItem.leftBarButtonItem  = backButtonItem
    }

    @objc func backButtonClickedDismiss(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

    func settingsNavBarImage() {
        navigationController?.clearBackground()
    }
}

extension BaseViewController {
    func displaySimpleAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
}
