//
//  AboutViewController.swift
//  Egon_iOSHonoluluProject
//
//  Created by mobapp03 on 30/01/2020.
//  Copyright © 2020 mobapp03. All rights reserved.
//

import Foundation
import UIKit

class AboutViewController: UIViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //Array van images aanmaken
   var images: [String] = ["HonoluluFlag.jpg","honoluluSlide2.jpg","honoluluSlide3.jpg","honoluluSlide4.jpg"]
   var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        
        for index in 0..<images.count {
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            
            let imageView = UIImageView(frame: frame)
            imageView.image = UIImage(named: images[index])
            self.scrollView.addSubview(imageView)
        }
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(images.count), height: scrollView.frame.size.height)
        scrollView.delegate = self
    }
    //Page Controller toevoegen + functioneren
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var page = scrollView.contentOffset.x/scrollView.frame.size.width
        pageControl.currentPage = Int(page)
    }
}
