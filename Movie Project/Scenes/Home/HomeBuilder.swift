//
//  HomeBuilder.swift
//  Mobillium Project
//
//  Created Çağatay Eğilmez on 15.05.2022.
//  Copyright © 2022 Çağatay Eğilmez. All rights reserved.
//

import UIKit

struct HomeBuilder {
    static func build(apiClient: ServiceLayer) -> UIViewController {
        let viewModel = HomeViewModel(with: apiClient)
        let controller = HomeViewController(with: viewModel)
        viewModel.output = controller
        return controller
    }
}