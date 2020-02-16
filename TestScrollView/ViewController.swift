//
//  ViewController.swift
//  TestScrollView
//
//  Created by Trinh Thai on 2/16/20.
//  Copyright © 2020 Trinh Thai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    let bannerWidth = UIScreen.main.bounds.size.width
    let bannerHeight = 260
    var banner:UIScrollView!
    var pageControl:UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBanner()
        self.setupPageControl()
    }
    
    func setupBanner(){
        self.banner = UIScrollView(frame: CGRect(x: 0, y: 0, width: Int(bannerWidth), height: bannerHeight))
        self.banner.showsHorizontalScrollIndicator = false
        self.banner.bounces = false
        self.banner.isPagingEnabled = true
        self.banner.delegate = self
        
        for i in 0...4 {
            let w = Int(bannerWidth) * i
            let img = UIImageView(frame: CGRect(x: w, y: 0, width: Int(bannerWidth), height: bannerHeight))
            img.image = UIImage(named: "\(i)")
            
            self.banner.addSubview(img)
        }
        self.banner.contentSize = CGSize(width: bannerWidth * 5.0, height: 0)
        self.view.addSubview(self.banner)
    }
    
    func setupPageControl(){
        self.pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.red
        self.pageControl.numberOfPages = 5
        self.pageControl.center = CGPoint(x: bannerWidth * 0.5, y: 240.0)
        self.pageControl.addTarget(self, action: #selector(pageIndicate), for: .valueChanged)
        
        self.view.addSubview(self.pageControl)
    }
    
    
    @objc func pageIndicate(pageControl:UIPageControl){
        let currentIndex = pageControl.currentPage
        self.banner.setContentOffset(CGPoint(x: Int(bannerWidth)*currentIndex, y: 0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset
        let index = contentOffset.x / bannerWidth
        self.pageControl.currentPage = Int(index)
    }
}

