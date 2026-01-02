//
//  MovieDetailViewController.swift
//  Mobillium Project
//
//  Created Çağatay Eğilmez on 15.05.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class MovieDetailViewController: UIViewController {

    // MARK: - Properties
    private lazy var viewSource: MovieDetailView = {
        let view = MovieDetailView()
        view.delegate = viewModel
        return view
    }()

    var viewModel: MovieDetailViewModel

    // MARK: - Initialization
    init(with viewModel: MovieDetailViewModel) {
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
        self.title = viewModel.navTitle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        UIApplication.shared.statusBarUIView?.isHidden = false
        if #available(iOS 12.0, *) {
            switch traitCollection.userInterfaceStyle {
            case .light, .unspecified:
                UIApplication.shared.statusBarUIView?.backgroundColor = .white
                self.navigationController?.navigationBar.backgroundColor = .white
            case .dark:
                UIApplication.shared.statusBarUIView?.backgroundColor = .black
                self.navigationController?.navigationBar.backgroundColor = .black
            @unknown default:
                UIApplication.shared.statusBarUIView?.backgroundColor = .white
                self.navigationController?.navigationBar.backgroundColor = .white
            }
        } else {
            UIApplication.shared.statusBarUIView?.backgroundColor = .white
            self.navigationController?.navigationBar.backgroundColor = .white
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarUIView?.isHidden = true
    }
    

}

extension MovieDetailViewController: MovieDetailViewModelOutput {
    func imdbRedirect() {
        if let movie = viewModel.movie {
            if let url = URL(string: "https://www.imdb.com/title/"+movie.imdb_id+"/") {
                UIApplication.shared.open(url)
            }
        }
    }
    
    func showError(with: String) {
        let langStr = Locale.current.languageCode
        self.showAlert(cancelName: (langStr?.contains("tr"))! ? "İptal" : "Cancel",
                       buttonName: (langStr?.contains("tr"))! ? "Tamam" : "OK",
                       message: with)
    }
    
    func showLoader(show: Bool) {
        if show {
            self.startLoader()
        } else {
            self.stopLoader()
        }
    }
    
    
    func refreshUI() {
        if let movie = viewModel.movie {
            if let imageUrl = movie.imageUrl {
                viewSource.movieImage.loadKF(imageUrl)
            } else {
                viewSource.movieImage.image = UIImage(named: "placeholderImage")
            }
            
            let attributedString = NSMutableAttributedString(string: "\(movie.vote_average ?? 0.0)/10", attributes: [.foregroundColor: UIColor(hex: "#ADB5BD")])
            attributedString.addAttribute(.foregroundColor, value: UIColor(hex: "#2B2D42"), range: NSRange(location: 0, length: 3))
            viewSource.rateLabel.attributedText = attributedString
            
            viewSource.dateLabel.text = "\(movie.releaseDate.day()).\(movie.releaseDate.month()).\(movie.releaseDate.year())"
            
            viewSource.titleLabel.text = movie.title + " (\(movie.releaseDate.year()))"
            
            viewSource.descriptionLabel.text = movie.overview
            viewSource.descriptionLabel.sizeToFit()
            
            viewSource.scrollView.sizeToFit()
            
            let contentRect: CGRect = viewSource.scrollView.subviews.reduce(into: .zero) { rect, view in
                rect = rect.union(view.frame)
            }
            viewSource.scrollView.contentSize.height = contentRect.size.height + (self.navigationController?.navigationBar.frame.height)!
        }
    }
    
}
