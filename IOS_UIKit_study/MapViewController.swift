//
//  ViewController.swift
//  IOS_UIKit_study
//
//  Created by RONICK on 2021/07/18.
//
import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var myMap: MKMapView!
    @IBOutlet var lbLocationInfo1: UILabel!
    @IBOutlet var lbLocationInfo2: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbLocationInfo1.text = ""
        lbLocationInfo2.text = ""
        locationManager.delegate = self // 델리게이트 설정함
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 정확도 최고로 설정
        locationManager.requestWhenInUseAuthorization() // 위치데이터 추적 승인 요청
        locationManager.startUpdatingLocation() // 위치 업데이트 시작
        myMap.showsUserLocation = true // 유저 현재 위치 보기로 설정
        
    }
    
    // 위도값, 경도값, 범위값을 가지는 지도를 보여주기
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue) // 중심 설정
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span) // 범위 설정
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue) // 특정 중심에서 특정 범위를 가지는 region 생성
        
        myMap.setRegion(pRegion, animated: true) // 설정한 값으로 지도 보여주기
        
        return pLocation
    }
    
    // 핀을 설치하자
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double, title strTitle: String, subtitle strSubtitle: String) {
        
        let annotation = MKPointAnnotation() // 핀 설치를 위한 클래스
        
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span) // 핀 위치 설정
        
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        myMap.addAnnotation(annotation) // 핀을 꽂아버린다
    }
    
    
    
    // 위치 업데이트후 지도에 위치를 표시
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("DEBUG: ????????")
        let pLocation = locations.last // 가장 최근의 위치 값
        guard let latitude = pLocation?.coordinate.latitude else { return } // 위도
        guard let longitude = pLocation?.coordinate.longitude else { return } // 경도
        
        // delta: 0.01 --->  지도를 100배 확대해서 보여줌, 0~1 사이의 실수
        _ = goLocation(latitudeValue: latitude, longitudeValue: longitude, delta: 0.01)
        
        CLGeocoder().reverseGeocodeLocation(pLocation!) { placemarks, error in
            
            let pm = placemarks!.first
            let country = pm!.country  // 현재 위치해 있는 곳의 국가
            
            var address: String = country!
            
            if pm!.locality != nil { // 지역이 존재하면 추가
                address += " "
                address += pm!.locality!
            }
            
            if(pm!.thoroughfare != nil) { // 도로가 존재하면 추가
                address += " "
                address += pm!.thoroughfare!
            }
            
            self.lbLocationInfo1.text = "현재 위치"
            self.lbLocationInfo2.text = address
        }
        
        locationManager.stopUpdatingLocation() // 위치 업데이트. 멈춰!!
    }
    
    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
         
        case 0: self.lbLocationInfo1.text = ""
                self.lbLocationInfo2.text = ""
                locationManager.startUpdatingLocation()
            
        case 1: setAnnotation(latitudeValue: 37.526250063559175, longitudeValue: 126.93375046571347, delta: 1, title: "여의도 한강공원", subtitle: "여의도 한강공원이다")
            
        case 2: setAnnotation(latitudeValue: 37.55636, longitudeValue: 126.972382, delta: 1, title: "서울역", subtitle: "큼")
            
        case 3: setAnnotation(latitudeValue: 37.489014795050075, longitudeValue: 126.92041278531427, delta: 1, title: "우리집", subtitle: "myHome")
            
        default:
            return
        }
    }
}
