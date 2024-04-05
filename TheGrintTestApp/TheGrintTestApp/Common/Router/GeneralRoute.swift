//
//  GeneralRoute.swift
//  TheGrintTestApp
//
//  Created by Angelber Castro on 4/4/24.
//

import Foundation
import UIKit

enum GeneralRoute: IRouter {
    case home
}

extension GeneralRoute {
    var scene: UIViewController? {
        switch self {
        case .home:
            return HomeViewController()
        }
    }
}
