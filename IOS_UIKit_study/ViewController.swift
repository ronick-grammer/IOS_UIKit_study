//
//  ViewController.swift
//  IOS_UIKit_study
//
//  Created by RONICK on 2021/07/18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnToImageView(_ sender: UIButton) {
        tabBarController?.selectedIndex = 1 // [1] 번째 뷰로 이동
    }
    
    @IBAction func btnToMapView(_ sender: UIButton) {
        tabBarController?.selectedIndex = 3 // [3] 번째 뷰로 이동
    }
    
}

