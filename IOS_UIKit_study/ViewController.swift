//
//  ViewController.swift
//  IOS_UIKit_study
//
//  Created by RONICK on 2021/07/18.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let MAX_ARRAY_NUM = 10 // 사진 갯수
    let PICKER_VIEW_COLUMN = 2 // 컴포넌트 갯수
    let PICKER_VIEW_HEIGHT: CGFloat = 80 // 컴포넌트 요쇼의 높이
    var imageArray = [UIImage?]()
    var imageFileName = ["1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg", "6.jpg", "7.jpg",
                         "8.jpg", "9.jpg", "10.jpg"]
    
    @IBOutlet var pickerImage: UIPickerView!
    @IBOutlet var lbImageFileName: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0 ..< MAX_ARRAY_NUM {
            let img = UIImage(named: imageFileName[i])
            imageArray.append(img)
        }
        
        lbImageFileName.text = imageFileName[0]
        imageView.image = imageArray[0]
    }
    
    // 피커뷰에 표시될 열의 개수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return PICKER_VIEW_COLUMN
    }
    
    // 피커뷰 컴포넌트의 높이
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return PICKER_VIEW_HEIGHT
    }
    
    // 피커뷰의 열에 선택할수 있는 행(데이터)의 개수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageFileName.count
    }
    
    // 피커뷰의 열에서 선택할수 있는 각 행(데이터)의 이미지 뷰
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(image: imageArray[row])
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 150)
        
        return imageView
    }
    
    // 피커뷰의 특정 컴포넌트를 선택했을 때 수행
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 { // 첫번째 컴포넌트
            lbImageFileName.text = imageFileName[row]
        } else { // 두번째 컴포넌트
            imageView.image = imageArray[row]
        }
    }
}
