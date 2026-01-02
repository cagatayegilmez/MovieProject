//
//  CarouselCollectionViewCell.swift
//  Mobillium Project
//
//  Created by Çağatay Eğilmez on 15.05.2022.
//

import Foundation
import UIKit

final class CarouselCollectionViewCell: UICollectionViewCell {
    
    private lazy var gradientLayer: UIView = {
        let view = UIView()
        view.alpha = 0.4
        return view
    }()
    
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private(set) lazy var titleLabel = UILabel.create(text: "",
                                                      numberOfLines: 0,
                                                      font: UIFont.boldSystemFont(ofSize: 20),
                                                      textColor: .white,
                                                      textAlignment: .left)
    
    private(set) lazy var subTitleLabel = UILabel.create(text: "",
                                                         numberOfLines: 2,
                                                         font: UIFont.systemFont(ofSize: 12),
                                                         textColor: .white,
                                                         textAlignment: .left)
    
    static let cellId = "CarouselCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        arrangeViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func arrangeViews(){
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(gradientLayer)
        
        imageView.fillSuperview()
        
        titleLabel.anchor(leading: contentView.leadingAnchor,
                          bottom: contentView.bottomAnchor,
                          trailing: contentView.trailingAnchor,
                          leadingPadding: 16, bottomPadding: 80, trailingPadding: 16)
        
        subTitleLabel.anchor(top: titleLabel.bottomAnchor,
                             leading: contentView.leadingAnchor,
                             trailing: contentView.trailingAnchor,
                             topPadding: 8, leadingPadding: 16, trailingPadding: 16)
        
        let gl = CAGradientLayer()
        let colorTop = UIColor.white.cgColor
        let colorBottom = UIColor(hex: "#434343").cgColor

        gl.colors = [colorTop, colorBottom]
        gl.locations = [0.0, 1.0]
        gl.frame = gradientLayer.frame
        gradientLayer.layer.insertSublayer(gl, at: 0)
        
        gradientLayer.fillSuperview()
    }
    
    func populateUI(with datasource: MovieListModel){
        if let imageUrl = datasource.imageUrl {
            imageView.loadKF(imageUrl)
        } else {
            imageView.image = UIImage(named: "placeholderImage")
        }
        
        titleLabel.text = datasource.title + " (\(datasource.releaseDate.year()))"
        titleLabel.sizeToFit()
        subTitleLabel.text = datasource.overview
        subTitleLabel.sizeToFit()
        self.layoutIfNeeded()
    }
}

