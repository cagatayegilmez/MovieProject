//
//  MovieDetailBuilder.swift
//  Mobillium Project
//
//  Created Çağatay Eğilmez on 15.05.2022.
//  Copyright © 2022 Çağatay Eğilmez. All rights reserved.
//

import UIKit

struct MovieDetailBuilder {
    static func build(apiClient: ServiceLayer,
                      movieId: Int,
                      title: String) -> UIViewController {
        let viewModel = MovieDetailViewModel(with: apiClient,
                                             movieId: movieId,
                                             title: title)
        let controller = MovieDetailViewController(with: viewModel)
        viewModel.output = controller
        return controller
    }
}
