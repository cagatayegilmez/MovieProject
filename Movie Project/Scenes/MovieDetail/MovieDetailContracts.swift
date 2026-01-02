//
//  MovieDetailContracts.swift
//  Mobillium Project
//
//  Created Çağatay Eğilmez on 15.05.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol MovieDetailViewModelInput: MovieDetailViewDelegate {
    func viewDidLoad()
}

protocol MovieDetailViewModelOutput: AnyObject {
    func refreshUI()
    func showError(with: String)
    func showLoader(show: Bool)
    func imdbRedirect()
}
