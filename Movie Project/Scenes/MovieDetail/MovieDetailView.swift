//
//  MovieDetailView.swift
//  Mobillium Project
//
//  Created Çağatay Eğilmez on 15.05.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//


import UIKit

protocol MovieDetailViewDelegate: AnyObject {
    func imdbRedirect()
}

final class MovieDetailView: UIView {

	// MARK: - Properties
    
    private(set) lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .white
        return view
    }()
    
    private(set) lazy var movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.sizeAnchor(width: screenSize.width, height: screenSize.height/3.17)
        return image
    }()
    
    private lazy var imdbIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "imdb")
        view.contentMode = .scaleAspectFill
        view.sizeAnchor(width: 49, height: 24)
        view.addTapGestureRecognizer {[weak self] in
            self?.delegate?.imdbRedirect()
        }
        return view
    }()
    
    private lazy var starIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "star")
        view.contentMode = .scaleAspectFill
        view.sizeAnchor(width: 16, height: 16)
        return view
    }()
    
    private(set) lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var dotView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#E6B91E")
        view.layer.cornerRadius = 2.5
        view.sizeAnchor(width: 5, height: 5)
        return view
    }()
    
    private(set) lazy var dateLabel = UILabel.create(text: "",
                                                     numberOfLines: 0,
                                                     font: UIFont.systemFont(ofSize: 13),
                                                     textColor: UIColor(hex: "#2B2D42"),
                                                     textAlignment: .center)
    
    private(set) lazy var titleLabel = UILabel.create(text: "",
                                                      numberOfLines: 0,
                                                      font: UIFont.boldSystemFont(ofSize: 20),
                                                      textColor: UIColor(hex: "#2B2D42"),
                                                      textAlignment: .left)
    
    private(set) lazy var descriptionLabel: UILabel = {
        let label = UILabel.create(text: "",
                                   numberOfLines: 0,
                                   font: UIFont.systemFont(ofSize: 15),
                                   textColor: UIColor(hex: "#2B2D42"),
                                   textAlignment: .left)
        label.sizeAnchor(width: screenSize.width - 32)
        return label
    }()

    let screenSize = UIScreen.main.bounds
    weak var delegate: MovieDetailViewDelegate?
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
        addSubview(scrollView)
        scrollView.addSubview(movieImage)
        scrollView.addSubview(imdbIcon)
        scrollView.addSubview(starIcon)
        scrollView.addSubview(rateLabel)
        scrollView.addSubview(dotView)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(descriptionLabel)
        
        scrollView.fillSuperview()
        
        movieImage.anchor(top: scrollView.topAnchor,
                          leading: scrollView.leadingAnchor)
        
        imdbIcon.anchor(top: movieImage.bottomAnchor,
                        leading: scrollView.leadingAnchor,
                        topPadding: 16, leadingPadding: 16)
        
        starIcon.anchor(leading: imdbIcon.trailingAnchor,
                        leadingPadding: 8)
        starIcon.centerYAnchor.constraint(equalTo: imdbIcon.centerYAnchor).isActive = true
        
        rateLabel.anchor(leading: starIcon.trailingAnchor,
                         leadingPadding: 4)
        rateLabel.centerYAnchor.constraint(equalTo: starIcon.centerYAnchor).isActive = true
        
        dotView.anchor(leading: rateLabel.trailingAnchor,
                       leadingPadding: 8)
        dotView.centerYAnchor.constraint(equalTo: rateLabel.centerYAnchor).isActive = true
        
        dateLabel.anchor(leading: dotView.trailingAnchor,
                         leadingPadding: 8)
        dateLabel.centerYAnchor.constraint(equalTo: dotView.centerYAnchor).isActive = true
        
        titleLabel.anchor(top: imdbIcon.bottomAnchor,
                          leading: scrollView.leadingAnchor,
                          topPadding: 16, leadingPadding: 16)
        
        descriptionLabel.anchor(top: titleLabel.bottomAnchor,
                                leading: scrollView.leadingAnchor,
                                topPadding: 16, leadingPadding: 16)
    }
}

