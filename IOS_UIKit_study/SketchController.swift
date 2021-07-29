//
//  SketchController.swift
//  IOS_UIKit_study
//
//  Created by RONICK on 2021/07/29.
//

import UIKit

class SketchController: UIViewController {
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var txtLineWidth: UITextField!
    
    var lastPoint: CGPoint! // 터지하거나 이동한 위치
    var lineSize: CGFloat! // 선 두께
    var lineColor = UIColor.red.cgColor // 선 색상
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineSize = CGFloat((txtLineWidth.text! as NSString).floatValue) // 텍스트 필드의 문자를 숫자로 변경
    }
    
    @IBAction func btnClear(_ sender: UIButton) { // 이미지 지우기
        imgView.image = nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch // 터치 이벤트 가지고 오기
        
        lastPoint = touch.location(in: imgView) // 이미지에서의 터치 위치 가져오기
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imgView.frame.size) // 콘텍스트 크기를 이미지 뷰 크기와 같게 생성
        
        lineSize = CGFloat((txtLineWidth.text! as NSString).floatValue)
        let context = UIGraphicsGetCurrentContext()! // 생성한 콘텍스트 정보 가져오기
        context.setStrokeColor(lineColor) // 선 색 설정
        context.setLineCap(CGLineCap.round) // 라인 끝모양을 둥글게
        context.setLineWidth(lineSize) // 선 두께 설정
        
        let touch = touches.first! as UITouch // 현재 터치 이벤트 가져오기
        let currentPoint = touch.location(in: imgView) // 이미지에서의 현재 터치 위치 가져오기
        
        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.width, height: imgView.frame.height)) // 컨텍스트 내에 있는 이미지 뷰의 이미지를 이미지 뷰 크기 내에서 그리도록 설정(기존 이미지에 그림을 계속 누적)
        
        context.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y)) // 직전 위치로 시작위치를 옮기고
        context.addLine(to: CGPoint(x: currentPoint.x, y: currentPoint.y)) // 그 위치에서 현재 위치 까지 선을 그림
        context.strokePath() // 그러고나서 콘텍스트에 반영하기
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext() // 콘텍스트에 그려진 이미지를 저장
        UIGraphicsEndImageContext() // 그리기 마침
        
        lastPoint = currentPoint // 이렇게 반복
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        
        lineSize = CGFloat((txtLineWidth.text! as NSString).floatValue)
        let context = UIGraphicsGetCurrentContext()!
        context.setStrokeColor(lineColor)
        context.setLineCap(CGLineCap.round)
        context.setLineWidth(lineSize)
        
        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.width, height: imgView.frame.height))
        
        // 터치를 땟을 때는 라인이 그리지 않고 마친다
        context.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        context.addLine(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        context.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake { // 흔들면 초기화
            imgView.image = nil
        }
    }
    
    @IBAction func btnLineColorBlack(_ sender: UIButton) {
        lineColor = UIColor.black.cgColor
    }
    
    @IBAction func btnLineColorRed(_ sender: UIButton) {
        lineColor = UIColor.red.cgColor
    }
    
    @IBAction func btnLineColorGreen(_ sender: UIButton) {
        lineColor = UIColor.green.cgColor
    }
    
    @IBAction func btnLineColorBlue(_ sender: UIButton) {
        lineColor = UIColor.blue.cgColor
    }
}
