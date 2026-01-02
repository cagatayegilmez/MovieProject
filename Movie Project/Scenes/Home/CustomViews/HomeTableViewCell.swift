//
//  HomeTableViewCell.swift
//  Mobillium Project
//
//  Created by Çağatay Eğilmez on 15.05.2022.
//


import UIKit

final class HomeTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private lazy var filmImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.opacity = 10
        view.sizeAnchor(width: 104, height: 104)
        return view
    }()
    
    private lazy var titleLabel = UILabel.create(text: "",
                                                 numberOfLines: 0,
                                                 font: UIFont.boldSystemFont(ofSize: 15),
                                                 textColor: UIColor(hex: "#2B2D42"),
                                                 textAlignment: .left)
    
    private lazy var subTitleLabel = UILabel.create(text: "",
                                                    numberOfLines: 2,
                                                    font: UIFont.systemFont(ofSize: 13),
                                                    textColor: UIColor(hex: "#8D99AE"),
                                                    textAlignment: .left)
    
    private lazy var dateLabel = UILabel.create(text: "",
                                                numberOfLines: 0,
                                                font: UIFont.systemFont(ofSize: 12),
                                                textColor: UIColor(hex: "#8D99AE"),
                                                textAlignment: .right)
    
    private lazy var arrow: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "next")
        view.contentMode = .scaleAspectFill
        view.sizeAnchor(width: 6, height: 10.5)
        return view
    }()
    
    private lazy var line: UIView = {
        let view = UIView()
        view.sizeAnchor(height: 1)
        view.backgroundColor = UIColor(hex: "#E9ECEF")
        return view
    }()
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle = .default,
                  reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(filmImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(arrow)
        contentView.addSubview(line)
        
        filmImage.anchor(leading: contentView.leadingAnchor,
                         leadingPadding: 16)
        filmImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        titleLabel.anchor(top: contentView.topAnchor,
                          leading: filmImage.trailingAnchor,
                          trailing: contentView.trailingAnchor,
                          topPadding: 24, leadingPadding: 8, trailingPadding: 44)
        
        subTitleLabel.anchor(top: titleLabel.bottomAnchor,
                             leading: filmImage.trailingAnchor,
                             trailing: contentView.trailingAnchor,
                             topPadding: 8, leadingPadding: 8, trailingPadding: 44)
        
        dateLabel.anchor(top: subTitleLabel.bottomAnchor,
                         trailing: contentView.trailingAnchor,
                         topPadding: 16, trailingPadding: 44)
        
        arrow.anchor(trailing: contentView.trailingAnchor,
                     trailingPadding: 19)
        arrow.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        line.anchor(leading: contentView.leadingAnchor,
                    bottom: contentView.bottomAnchor,
                    trailing: contentView.trailingAnchor,
                    leadingPadding: 16, trailingPadding: 16)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Arrange Views
    func populateUI(model: MovieListModel){
        if let imageURL = model.imageUrl {
            self.filmImage.loadKF(imageURL)
        } else {
            self.filmImage.image = UIImage(named: "placeholderImage")
        }
        titleLabel.text = model.title
        subTitleLabel.text = model.overview
        dateLabel.text = "\(model.releaseDate.day()).\(model.releaseDate.month()).\(model.releaseDate.year())"
        titleLabel.sizeToFit()
        subTitleLabel.sizeToFit()
        dateLabel.sizeToFit()
        
        self.contentView.layoutIfNeeded()
    }
}

