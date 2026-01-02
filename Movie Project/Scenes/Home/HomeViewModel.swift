//
//  HomeViewModel.swift
//  Mobillium Project
//
//  Created Çağatay Eğilmez on 15.05.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

final class HomeViewModel {
    
    // MARK: - Properties
    let api: ServiceLayer
    weak var output: HomeViewModelOutput?
    var currentPage: Int = 1
    var nowPlayingMovies = [MovieListModel]()
    var upcomingMovies = [MovieListModel]()
    
    init(with apiClient: ServiceLayer) {
        api = apiClient
    }
}

// MARK: - API
extension HomeViewModel {
    private func fetchData() {
        self.output?.showLoader(show: true)
        let req = GetNowPlayingListRequest()
        api.send(request: req) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.nowPlayingMovies = response.results
                self.getUpcomingList()
            case .failure(let error):
                self.output?.showLoader(show: false)
                self.output?.showError(with: error.localizedDescription)
            }
        }
    }
    
    func getUpcomingList() {
        let req = GetUpcomingListRequest(page: currentPage)
        api.send(request: req) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                for movie in response.results {
                    self.upcomingMovies.append(movie)
                }
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
extension HomeViewModel: HomeViewModelInput {
    func redirectionMoviewDetail(movieId: Int!) {
        self.output?.redirectionMoviewDetail(movieId: movieId)
    }
    
    func viewDidLoad() {
        fetchData()
    }
    
    func refreshTable() {
        self.currentPage = 0
        getUpcomingList()
    }
}
