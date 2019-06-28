//
//  ViewController.swift
//  newsApp
//
//  Created by Akiko Sato on 2019/06/02.
//  Copyright © 2019 Akiko Sato. All rights reserved.
//

import UIKit
import SegementSlide

class ViewController: SegementSlideViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
        scrollToSlide(at: 0, animated: false)
        // Do any additional setup after loading the view.
    }

    override var headerHeight: CGFloat? {
        return view.bounds.height/4
    }
    
    override var headerView: UIView? {
        
        let headerView = UIImageView()
        headerView.isUserInteractionEnabled = true
        headerView.contentMode = .scaleAspectFill
        headerView.image = UIImage(named: "header")
        return headerView
    }
    
    override var titlesInSwitcher: [String] {
        return ["Yahoo!ニュース", "いぬのきもち", "BUSINESS INSIDER JAPAN ", "ねこのきもち", "WIRED.jp", "VOGUE"]
    }
    
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
//        return ContentViewController()
        switch index {
            case 0:
            return Page1ViewController()
            case 1:
            return Page2ViewController()
            case 2:
            return Page3ViewController()
            case 3:
            return Page4ViewController()
            case 4:
            return Page5ViewController()
            case 5:
            return Page6ViewController()
        default:
            return Page1ViewController()
        }
    }
    
}

