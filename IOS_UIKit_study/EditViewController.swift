//
//  EditViewController.swift
//  IOS_UIKit_study
//
//  Created by RONICK on 2021/07/27.
//

import UIKit

protocol EditDelegate {
    func didMessageEditDone(_ controller: EditViewController, message: String)
    
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool)
    
    func didImageZoomDone(_ controller: EditViewController, isZoom: Bool)
}

class EditViewController: UIViewController {
    
    var textWayValue: String = ""
    var textMessage: String = ""
    var delegate: EditDelegate?
    var isOn = false
    
    let zoomInText = "확대"
    let zoomOutText = "축소"
    var isZoom = false
    
    @IBOutlet var btnZoomObj: UIButton!
    @IBOutlet var lblWay: UILabel!
    @IBOutlet var txMessage: UITextField!
    @IBOutlet var switchOn: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblWay.text = textWayValue
        txMessage.text = textMessage
        switchOn.isOn = isOn
        
        // 확대면 '축소'버튼, 축소면 '확대'버튼
        btnZoomObj.setTitle(isZoom ? zoomOutText : zoomInText, for: .normal)
    }
    
    @IBAction func btnDone(_ sender: UIButton) {
        if delegate != nil {
            delegate?.didMessageEditDone(self, message: txMessage.text!)
            delegate?.didImageOnOffDone(self, isOn: isOn)
        }
        _ = navigationController?.popViewController(animated: true) // 전 뷰로 이동(뒤로가기)
    }
    
    
    @IBAction func btnZoom(_ sender: UIButton) {
        isZoom = !isZoom
        
        if delegate != nil {
            delegate?.didImageZoomDone(self, isZoom: isZoom)
        }
        
        btnZoomObj.setTitle(isZoom ? zoomOutText : zoomInText, for: .normal)
    }
    
    @IBAction func swImageOnOff(_ sender: UISwitch) {
        if sender.isOn {
            isOn = true
        } else {
            isOn = false
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
