//
//  MovieDetailViewModel.swift
//  Mobillium Project
//
//  Created Çağatay Eğilmez on 15.05.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

final class MovieDetailViewModel {
    
    // MARK: - Properties
    let api: ServiceLayer
    var id: Int
    var navTitle: String
    var movie: MovieDetailModel?
    weak var output: MovieDetailViewModelOutput?
    
    init(with apiClient: ServiceLayer,
         movieId: Int,
         title: String) {
        api = apiClient
        id = movieId
        navTitle = title
    }
}

// MARK: - API
extension MovieDetailViewModel {
    private func fetchData() {
        self.output?.showLoader(show: true)
        let req = GetMovieDetailRequest(movieId: id)
        api.send(request: req) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                self.movie = result
                self.output?.showLoader(show: false)
                self.output?.refreshUI()
            case .failure(let error):
                self.output?.showLoader(show: false)
                self.output?.showError(with: error.localizedDescription)
            }
        }
    }
}

// MARK: - Input
extension MovieDetailViewModel: MovieDetailViewModelInput {
    func imdbRedirect() {
        self.output?.imdbRedirect()
    }
    
    func viewDidLoad() {
        fetchData()
    }
}
