//
//  EmergencyViewTVMapCell.swift
//  SaveUs
//
//  Created by Ruyha on 2023/05/28.
//

import UIKit
import Reusable
import SnapKit
import Then
import MapKit


class EmergencyViewTVMapCell: UITableViewCell, Reusable {
    
    var safeAreaWidth: CGFloat {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
            let safeAreaInsets = keyWindow.safeAreaInsets
            return (keyWindow.bounds.width - safeAreaInsets.left - safeAreaInsets.right) / 2
        }
        return 0
    }
    
    ///컨텐츠 들어갈 뷰
    private let conView: UIView = .init().then{
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.layer.borderWidth = 3
    }
    
    ///지도를 보여줄 화면
    private lazy var mapVeiw: MKMapView = .init()
    
    
    private lazy var exLabel: UILabel = .init().then{
        $0.text = "환경에 따라 위치기 부정확 할 수도 있습니다."
        $0.textColor = .gray
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    private lazy var mapLabel: UILabel = .init().then{
        $0.text = "_\n_"
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    ///위치가져오는애
    private lazy var locationManager : CLLocationManager = .init().then{
        $0.delegate = self
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setView()
        setMap()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension EmergencyViewTVMapCell: CLLocationManagerDelegate {
    
    
    func setMap(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapVeiw.showsUserLocation = true
    }
    
    func goLocation(latitudeValue: CLLocationDegrees,
                    longtudeValue: CLLocationDegrees,
                    delta span: Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longtudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        mapVeiw.setRegion(pRegion, animated: true)
        return pLocation
    }
    
    func setAnnotation(latitudeValue: CLLocationDegrees,
                       longitudeValue: CLLocationDegrees,
                       delta span :Double,
                       title strTitle: String,
                       subtitle strSubTitle:String){
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longtudeValue: longitudeValue, delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubTitle
        mapVeiw.addAnnotation(annotation)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!,
                       longtudeValue: (pLocation?.coordinate.longitude)!,
                       delta: 0.0015)
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(pLocation!) { placemarks, error in
            if error != nil {
                return
            }
            
            guard let placemark = placemarks?.first else { return }
            self.mapLabel.text = "나의 위치\n\(placemark.locality ?? "") \(placemark.name ?? "")"
        }
        locationManager.stopUpdatingLocation()
    }
    
//    func convertCLLocationToAddress(location: CLLocation) {
//        let geocoder = CLGeocoder()
//        geocoder.reverseGeocodeLocation(location) { placemarks, error in
//            if error != nil {
//                return
//            }
//            guard let placemark = placemarks?.first else { return }
//            self.mapLabel.text = "나의 위치: \(placemark.locality ?? "") \(placemark.name ?? "")"
//        }
//    }
    
}

extension EmergencyViewTVMapCell {
    
    private func setView(){
        contentView.addSubview(conView)
        conView.addSubview(mapVeiw)
        conView.addSubview(exLabel)
        conView.addSubview(mapLabel)

        conView.snp.makeConstraints{
//            conView.backgroundColor = .gray
//            $0.height.equalTo(100)
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview()
        }
        
        mapLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)

        }

        exLabel.snp.makeConstraints{
            $0.top.equalTo(mapLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }

        mapVeiw.snp.makeConstraints{
            $0.height.equalTo(safeAreaWidth-32)
            $0.top.equalTo(exLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        
        
        
        
    }
    
}
