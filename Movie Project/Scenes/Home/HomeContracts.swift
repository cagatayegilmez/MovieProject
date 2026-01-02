//
//  HomeContracts.swift
//  Mobillium Project
//
//  Created Çağatay Eğilmez on 15.05.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol HomeViewModelInput: HomeViewDelegate {
    func viewDidLoad()
}

protocol HomeViewModelOutput: AnyObject {
    func refreshUI()
    func showError(with: String)
    func redirectionMoviewDetail(movieId: Int!)
    func showLoader(show: Bool)
}
