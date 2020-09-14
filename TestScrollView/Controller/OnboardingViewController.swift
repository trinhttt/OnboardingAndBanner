//
//  OnboardingViewController.swift
//  TestScrollView
//
//  Created by Trinh Thai on 9/14/20.
//  Copyright © 2020 Trinh Thai. All rights reserved.
//

import UIKit

class OnboardingController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var imageViews = [UIImageView]()
    
    private var items: [OnboardingItem] = []
    
    private func setupPlaceholderItems() {
        items = OnboardingItem.placeholderItems
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPlaceholderItems()
        setupCollectionView()
        setupPageControl()
        setupImageViews()
        
    }
    
    private func setupImageViews() {
        items.forEach { (item) in
            let imageView = UIImageView(image: item.image)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.alpha = 0
            containerView.addSubview(imageView)
            NSLayoutConstraint.activate([
                imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.8),
                imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
            ])
            imageViews.append(imageView)
        }
        imageViews.first?.alpha = 1.0
        containerView.bringSubviewToFront(collectionView)
    }

    private func setupPageControl() {
        pageControl.numberOfPages = items.count
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }

    @IBAction func nextButtonTapped(_ sender: Any) {
        let nextRow = getCurrentIndex() + 1
        let nextIndexPath = IndexPath(row: nextRow, section: 0)
        collectionView.scrollToItem(at: nextIndexPath, at: .left, animated: true)
        pageControl.currentPage = nextIndexPath.item
        nextButton.isHidden = nextRow == items.count - 1
    }
    
    private func getCurrentIndex() -> Int {
        return Int(collectionView.contentOffset.x / collectionView.frame.width)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let index = getCurrentIndex()
        let fadeInAlpha = (x - collectionViewWidth * CGFloat(index)) / collectionViewWidth
        let fadeOutAlpha = CGFloat(1 - fadeInAlpha)
        
        if (index < items.count - 1) {
            imageViews[index].alpha = fadeOutAlpha
            imageViews[index + 1].alpha = fadeInAlpha
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = getCurrentIndex()
        nextButton.isHidden = getCurrentIndex() == items.count - 1
    }
    
    var collectionViewWidth: CGFloat {
        return collectionView.frame.size.width
    }
}


extension OnboardingController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        let item = items[indexPath.item]
        cell.delegate = self
        cell.showExploreButton(shouldShow: (indexPath.item == items.count - 1))
        cell.configure(with: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension OnboardingController: OnboardingCollectionViewCellDelegate {
    func didTapExploreButton() {
        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController")
        
        if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate,
            let window = sceneDelegate.window {
            window.rootViewController = mainVC
            UIView.transition(with: window,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        }
     
    }
}
