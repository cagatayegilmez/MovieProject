//
//  HomeView.swift
//  Mobillium Project
//
//  Created Çağatay Eğilmez on 15.05.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//


import UIKit

protocol HomeViewDelegate: AnyObject {
    func redirectionMoviewDetail(movieId: Int!)
    func refreshTable()
}

final class HomeView: UIView {

	// MARK: - Properties
    private(set) lazy var carouselView: CarouselView = {
        let view = CarouselView()
        view.delegate = self
        return view
    }()
    
    private lazy var refresher: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.tintColor = .gray
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return refresher
    }()
    
    private lazy var tableHeaderView: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        view.register(cell: HomeTableViewCell.self)
        view.separatorStyle = .none
        view.refreshControl = refresher
        return view
    }()

    let screenSize = UIScreen.main.bounds
    weak var delegate: HomeViewDelegate?
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        arrangeViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Arrange Views
    private func arrangeViews() {
        self.backgroundColor = .gray
        addSubview(tableView)
        tableHeaderView.addSubview(carouselView)
        
        tableView.anchor(top: self.topAnchor,
                         leading: self.leadingAnchor,
                         bottom: self.bottomAnchor,
                         trailing: self.trailingAnchor, topPadding: -75)
        
        tableHeaderView.frame = CGRect(x: 0, y: 0, width: self.screenSize.width, height: screenSize.height/2.7)
        tableView.tableHeaderView = tableHeaderView
        
        carouselView.fillSuperview()
    }
    
    @objc private func handleRefresh() {
        delegate?.refreshTable()
    }
}

//MARK: - CarouselView Delegate
extension HomeView: CarouselViewDelegate {
    func redirectionMoviewDetail(movieId: Int!) {
        self.delegate?.redirectionMoviewDetail(movieId: movieId)
    }
}
