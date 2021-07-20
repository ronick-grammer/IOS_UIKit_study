//
//  ViewController.swift
//  IOS_UIKit_study
//
//  Created by RONICK on 2021/07/18.
//

import UIKit

class ViewController: UIViewController {
    var current : Int = 1 // 첫 이미지
    var imageName: String {
        return String(current) + ".png"
    }
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var prev: UIButton!
    @IBOutlet var nex: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgView.image = UIImage(named: imageName)
    }
    
    @IBAction func btnPrev(_ sender: UIButton) {
        if current > 1 { // 첫번쨰 이미지까지
            current -= 1 //
        }
        imgView.image = UIImage(named: imageName)
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        if current < 3  { // 마지막 이미지까지
            current += 1
        }
        
        imgView.image = UIImage(named: imageName)
    }
    
    
    
}
