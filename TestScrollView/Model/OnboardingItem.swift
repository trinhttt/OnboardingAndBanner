//
//  OnboardingItem.swift
//  TestScrollView
//
//  Created by Trinh Thai on 9/14/20.
//  Copyright © 2020 Trinh Thai. All rights reserved.
//

import UIKit

struct OnboardingItem {
    let title: String
    let detail: String
    let image: UIImage?
    
    static let placeholderItems: [OnboardingItem] = [
        .init(title: "Title1",
              detail: "\"T1 \n T1 \n T1\"",
              image: UIImage(named: "0")),
        .init(title: "Title2",
              detail: "\"T2 \n T2 \n T2\"",
              image: UIImage(named: "1")),
        .init(title: "Title3",
              detail: "\"T3 \n T3 \n T3\"",
              image: UIImage(named: "2")),
        .init(title: "Title4",
              detail: "\"T4 \n T4 \n T4\"",
              image: UIImage(named: "3")),
        .init(title: "Title5",
              detail: "\"T5 \n T5 \n T5\"",
              image: UIImage(named: "4"))
    ]
}
