//
//  HomeViewController.swift
//  Mobillium Project
//
//  Created Çağatay Eğilmez on 15.05.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

    // MARK: - Properties
    private lazy var viewSource: HomeView = {
        let view = HomeView()
        view.delegate = viewModel
        view.tableView.delegate = self
        view.tableView.dataSource = self
        return view
    }()

    var viewModel: HomeViewModel

    // MARK: - Initialization
    init(with viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = viewSource
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
}

extension HomeViewController: HomeViewModelOutput {
    func showLoader(show: Bool) {
        if show {
            self.startLoader()
        } else {
            self.stopLoader()
        }
    }
    
    func redirectionMoviewDetail(movieId: Int!) {
        let title = viewModel.nowPlayingMovies.filter({ $0.id == movieId })[0].title
        let controller = MovieDetailBuilder.build(apiClient: viewModel.api,
                                                  movieId: movieId,
                                                  title: title)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    func refreshUI() {
        viewSource.carouselView.carouselData = viewModel.nowPlayingMovies
        DispatchQueue.main.async { [weak self] in
            self?.viewSource.tableView.reloadData()
        }
        self.view.layoutSubviews()
    }
    
    func showError(with: String) {
        let langStr = Locale.current.languageCode
        self.showAlert(cancelName: (langStr?.contains("tr"))! ? "İptal" : "Cancel",
                       buttonName: (langStr?.contains("tr"))! ? "Tamam" : "OK",
                       message: with)
    }
    
}

//MARK: -Tableview Delegate & Datasource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.upcomingMovies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.populateUI(model: viewModel.upcomingMovies[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = viewModel.upcomingMovies[indexPath.row].title
        let controller = MovieDetailBuilder.build(apiClient: viewModel.api,
                                                  movieId: viewModel.upcomingMovies[indexPath.row].id,
                                                  title: title)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            self.startLoader()
            viewModel.currentPage += 1
            viewModel.getUpcomingList()
        }
    }
}
