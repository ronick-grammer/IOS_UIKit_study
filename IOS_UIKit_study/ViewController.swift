//
//  ViewController.swift
//  IOS_UIKit_study
//
//  Created by RONICK on 2021/07/18.
//

import UIKit
import MobileCoreServices // 미디어 타입들을 정의해 놓음

// 카메라와 포토라이브러리를 사용하기 위한 프로토콜
class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var captureImage: UIImage!
    var videoURL: URL!
    var flagImageSave = false // 이미지 저장 여부

    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCaptureImageFromCamera(_ sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)) { // 카메라가 사용가능하다면
            flagImageSave = true // 카메라 촬영 후 이미지 저장
            
            imagePicker.delegate = self // 델리게이트를 self로 설정
            imagePicker.sourceType = .camera // 이미지 피커 소스 타입을 카메라로 설정
            imagePicker.mediaTypes = [kUTTypeImage as String] // 미디어 타입 설정
            imagePicker.allowsEditing = false // 편집 허용 x
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            myAlert("Camera inaccessible", message: "Application cannot access the camera.")
        }
    }
    
    @IBAction func btnLoadImageFromLibrary(_ sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            flagImageSave = false // 사진을 가져오는 것이므로 저장 X
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary // 포토 라이브러리 피커를 띄우기 위해서
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            myAlert("Photo album inaccessible", message: "Application cannot access the photo album.")
        }
    }
    
    @IBAction func btnRecordVideoFromCamera(_ sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)) {
            flagImageSave = true
            
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeMovie as String] // 비디오 타입
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            myAlert("Camera inaccessible", message: "Application cannot access the camera.")
        }
    }
    
    @IBAction func btnLoadVideoFromLibrary(_ sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            flagImageSave = false // 비디오를 가져오는 것이므로 저장 X
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            myAlert("Photo album inaccessible", message: "Application cannot access the photo album.")
        }
    }
    
    // 사용자가 사진이나 비디오를 촬영하거나 포토 라이브러리에서 선택이 끝났을 때 호출
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // 타입 가져오기
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        if(mediaType.isEqual(to: kUTTypeImage as NSString as String)) { // 사진 타입이면
            // 사진 가져오기
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            
            if flagImageSave { // 촬영이라면 이미지 저장
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            
            imgView.image = captureImage
        }
        else if(mediaType.isEqual(to: kUTTypeMovie as NSString as String)) { // 비디오 타입이면
            if flagImageSave { // 촬영이라면 비디오 저장
                // 촬영한 비디오를 가져와 저장
                videoURL = (info[UIImagePickerController.InfoKey.mediaURL] as! URL)
                UISaveVideoAtPathToSavedPhotosAlbum(videoURL.relativePath, self, nil, nil)
            }
        }
        
        self.dismiss(animated: true, completion: nil) // 완료 후 피커 닫기
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func myAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Ok!!!!", style: UIAlertAction.Style.default, handler: nil) // 확인
        
        alert.addAction(action) // 확인액션 등록
        present(alert, animated: true, completion: nil)
    }
}
