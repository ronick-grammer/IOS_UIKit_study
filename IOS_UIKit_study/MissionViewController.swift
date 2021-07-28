//
//  MissionViewController.swift
//  IOS_UIKit_study
//
//  Created by RONICK on 2021/07/28.
//

import UIKit
import MobileCoreServices

class MissionViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    var numImage: Int = 0
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var capturedImage: UIImage!
    var flagImageSave = false // 이미지 저장 여부
    
    
    @IBOutlet var imgViews: [UIImageView]! // collection 으로 관리하기 쉽게!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnCaptureImageFromCamera(_ sender: UIButton) {
        
        if(UIImagePickerController.isSourceTypeAvailable(.camera)) { // 카메라가 사용가능하다면
            flagImageSave = true // 카메라 촬영 후 이미지 저장
            
            imagePicker.delegate = self // 델리게이트를 self로 설정
            imagePicker.sourceType = .camera // 이미지 피커 소스 타입을 카메라로 설정
            imagePicker.mediaTypes = [kUTTypeImage as String] // 미디어 타입 설정
            imagePicker.allowsEditing = false // 편집 허용 x
            
            present(imagePicker, animated: true, completion: nil) // 피커 띄우기
        } else {
            myAlert("Camera inaccessible", message: "Application cannot access the camera.")
        }
    }
    
    @IBAction func btnLoadImageFromLibrary(_ sender: UIButton) {
        
        if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
            flagImageSave = false // 사진을 가져오는 것이므로 저장 X
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary // 포토 라이브러리 피커를 띄우기 위한 타입 설정
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            myAlert("Photo album inaccessible", message: "Application cannot access the photo album.")
        }
    }
    
    @IBAction func btnInitialize(_ sender: UIButton) {
        numImage = 0 // 초기화 이므로 인덱스도 처음부터 0 부터
        
        for i in 0 ..< imgViews.count { // 모든 이미지 초기화
            imgViews[i].image = nil
        }
    }
    
    // 사용자가 사진이나 비디오를 촬영하거나 포토 라이브러리에서 선택이 끝났을 때 호출
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // 타입 가져오기
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        if mediaType.isEqual(to: kUTTypeImage as NSString as String) { // 사진 타입이면
            // 사진 가져오기
            capturedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            
            if flagImageSave { // 촬영이라면 이미지 저장
                UIImageWriteToSavedPhotosAlbum(capturedImage, self, nil, nil)
            }
            
            imgViews[numImage].image = capturedImage
            numImage = (numImage == imgViews.count - 1) ? 0 : numImage + 1 // 이미지 인덱스를 초과하지 않도록. 초과하면 다시 첫 이미지부터 채움
        }
        
        self.dismiss(animated: true, completion: nil) // 피커 뷰 닫기
    }
    
    // 취소 누르면 피커뷰 닫기
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func myAlert(_ titile: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
