//
//  ViewController.swift
//  IOS_UIKit_study
//
//  Created by RONICK on 2021/07/18.
//

import UIKit

class ViewController: UIViewController, EditDelegate {
    let imgOn = UIImage(named: "lamp-on.png")
    let imgOff = UIImage(named: "lamp-off.png")
    
    let zoomScale: CGFloat = 2.0 // 줌 스케일 값
    
    var isOn = true
    var isZoom = true
    
    @IBOutlet var txMessage: UITextField!
    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgView.image = imgOn
    }
    
    func didMessageEditDone(_ controller: EditViewController, message: String) {
        txMessage.text = message
    }
    
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool) {
        if isOn {
            self.isOn = true
            imgView.image = imgOn
        } else {
            self.isOn = false
            imgView.image = imgOff
        }
    }
    
    func didImageZoomDone(_ controller: EditViewController, isZoom: Bool) {
        var newWidth: CGFloat, newHeight: CGFloat
        if isZoom { // 확대
            newWidth = imgView.frame.width * zoomScale
            newHeight = imgView.frame.height * zoomScale
        } else { // 축소
            newWidth = imgView.frame.width / zoomScale
            newHeight = imgView.frame.height / zoomScale
        }
        
        self.isZoom = isZoom 
        imgView.frame.size = CGSize(width: newWidth, height: newHeight)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // 다른 뷰로 전환 직전 호출
        // 세그웨이의 도착 컨트롤러를 EditViewController 타입으로 변환
        let editViewController = segue.destination as! EditViewController
        
        switch segue.identifier {
        case "editButton" : editViewController.textWayValue = "segue : use button"
        case "editBarButton": editViewController.textWayValue = "segue : use bar button"
        default : break
        }
        
        // 값 넘겨주기
        editViewController.textMessage = txMessage.text ?? ""
        editViewController.isOn = isOn
        editViewController.isZoom = isZoom
        editViewController.delegate = self // ** 전환되는 뷰와  데이터를 주고 받기위한 delegate
    }
}

