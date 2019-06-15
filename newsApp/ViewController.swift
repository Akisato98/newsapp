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
        return ["01", "02", "03", "04", "05", "06"]
    }
    
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
//        return ContentViewController()
        switch index {
            case 0:
            return Page1ViewController()
            case 1:
            return Page1ViewController()
            case 2:
            return Page1ViewController()
            case 3:
            return Page1ViewController()
            case 4:
            return Page1ViewController()
            case 5:
            return Page1ViewController()
        default:
            return Page1ViewController()
        }
    }
    
}

