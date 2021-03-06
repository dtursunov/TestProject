//
//  MainHomeRouter.swift
//  TestProject
//
//  Created Diyor Tursunov on 22/04/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

/// MainHome Module Router (aka: Wireframe)
class MainHomeRouter: MainHomeRouterProtocol {
    func showDetailsFor(item: ViewMainHomeEntity?, parent: UIViewController) {
        let view = DetailView()
        view.set(object: item)
        parent.navigationController?.pushViewController(view, animated: true)
    }
}
