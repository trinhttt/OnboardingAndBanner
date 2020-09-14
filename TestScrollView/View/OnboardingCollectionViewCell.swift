//
//  OnboardingCollectionViewCell.swift
//  TestScrollView
//
//  Created by Trinh Thai on 9/14/20.
//  Copyright © 2020 Trinh Thai. All rights reserved.
//

import UIKit

protocol OnboardingCollectionViewCellDelegate: class {
    func didTapExploreButton()
}
class OnboardingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var exploreButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    weak var delegate: OnboardingCollectionViewCellDelegate?
    
    func configure(with item: OnboardingItem) {
        titleLabel.text = item.title
        detailLabel.text = item.detail
    }
    
    func showExploreButton(shouldShow: Bool) {
        exploreButton.isHidden = !shouldShow
    }
    
    @IBAction func exploreButtonTapped(_ sender: Any) {
        delegate?.didTapExploreButton()
    }
}
