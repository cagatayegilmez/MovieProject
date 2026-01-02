//
//  CarouselView.swift
//  Mobillium Project
//
//  Created by Çağatay Eğilmez on 15.05.2022.
//

import Foundation
import UIKit

protocol CarouselViewDelegate: AnyObject {
    func redirectionMoviewDetail(movieId: Int!)
}

final class CarouselView: UIView {

    // MARK: - Properties
    
    private lazy var carouselCollectionView: UICollectionView = {
            let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
            collection.showsHorizontalScrollIndicator = false
            collection.isPagingEnabled = true
            collection.dataSource = self
            collection.delegate = self
            collection.register(CarouselCollectionViewCell.self, forCellWithReuseIdentifier: CarouselCollectionViewCell.cellId)
            collection.backgroundColor = .clear
            return collection
       }()
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.currentPage = 0
        control.currentPageIndicatorTintColor = UIColor.white
        control.pageIndicatorTintColor = UIColor.gray
        return control
    }()

    let screenSize = UIScreen.main.bounds
    weak var delegate: CarouselViewDelegate?
    var carouselData: [MovieListModel]? {
        didSet {
            if let carouselData = carouselData {
                pageControl.numberOfPages = carouselData.count
            }
            carouselCollectionView.reloadData()
        }
    }
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
        addSubview(carouselCollectionView)
        addSubview(pageControl)
        
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.itemSize = .init(width: screenSize.width, height: screenSize.height/2.7)
        carouselLayout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        carouselLayout.minimumLineSpacing = 0
        carouselCollectionView.collectionViewLayout = carouselLayout
        
        carouselCollectionView.fillSuperview()
        
        pageControl.anchor(leading: self.leadingAnchor,
                           bottom: self.bottomAnchor,
                           trailing: self.trailingAnchor,
                           leadingPadding: 16, bottomPadding: 16, trailingPadding: 16)
    }
}


extension CarouselView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let dataList = carouselData {
            return dataList.count
        } else {
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCollectionViewCell.cellId, for: indexPath) as? CarouselCollectionViewCell else { return UICollectionViewCell() }

        if let dataList = carouselData {
            cell.populateUI(with: dataList[indexPath.row])
        }

       return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let dataList = carouselData {
            self.delegate?.redirectionMoviewDetail(movieId: dataList[indexPath.row].id)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let visibleRect = CGRect(origin: carouselCollectionView.contentOffset, size: carouselCollectionView.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            if let visibleIndexPath = carouselCollectionView.indexPathForItem(at: visiblePoint) {
                pageControl.currentPage = visibleIndexPath.row
            }
        }
        
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            let visibleRect = CGRect(origin: carouselCollectionView.contentOffset, size: carouselCollectionView.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            if let visibleIndexPath = carouselCollectionView.indexPathForItem(at: visiblePoint) {
                pageControl.currentPage = visibleIndexPath.row
            }
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let visibleRect = CGRect(origin: carouselCollectionView.contentOffset, size: carouselCollectionView.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            if let visibleIndexPath = carouselCollectionView.indexPathForItem(at: visiblePoint) {
                pageControl.currentPage = visibleIndexPath.row
            }
        }
}
