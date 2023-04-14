//
//  MainViewController.swift
//  SaveUs
//
//  Created by Ruyha on 2023/03/28.
//

import UIKit
import MapKit

import SnapKit

class MainViewController: UIViewController {
    
    private lazy var mapVeiw: MKMapView = {
        let view = MKMapView()
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var testStackVeiw: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emergencyButton,
                                                       practiceButton,
                                                       explanationButton,
                                                       settingButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.layoutMargins = UIEdgeInsets(top: .zero, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var emergencyButton: UIButton = {
        let button = UIButton()
        button.setTitle("emergencyButton",for:.normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(didTapEmergencyButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var practiceButton: UIButton = {
        let button = UIButton()
        button.setTitle("practiceButton",for:.normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(didTapPracticeButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var explanationButton: UIButton = {
        let button = UIButton()
        button.setTitle("explanationButton",for:.normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(didTapExplanationButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var settingButton: UIButton = {
        let button = UIButton()
        button.setTitle("settingButton",for:.normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(didTapSettingButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var exLabel: UILabel = {
        let label = UILabel()
        label.text = "아이폰 설정에 따라\n위치기 부정확 할 수도 있습니다."
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var mapLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    //위치 가져오는 친구
    private lazy var locationManager : CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()
    
    //MARK: 생명주기 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setlayout()
        setMap()
    }
    
}

extension MainViewController : CLLocationManagerDelegate {
    
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
        let spanValue = MKCoordinateSpan(latitudeDelta: span,
                                         longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation,
                                         span: spanValue)
        mapVeiw.setRegion(pRegion, animated: true)
        return pLocation
    }
    
    func setAnnotation(latitudeValue: CLLocationDegrees,
                       longitudeValue: CLLocationDegrees,
                       delta span :Double,
                       title strTitle: String,
                       subtitle strSubTitle:String){
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitudeValue: latitudeValue,
                                           longtudeValue: longitudeValue,
                                           delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubTitle
        mapVeiw.addAnnotation(annotation)
    }
    
    //실시간 위치 확인
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!,
                       longtudeValue: (pLocation?.coordinate.longitude)!,
                       delta: 0.0008)
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(pLocation!) { placemarks, error in
            if error != nil {
                return
            }
            
            guard let placemark = placemarks?.first else { return }
            self.mapLabel.text = "\(placemark.locality ?? "") \(placemark.name ?? "")"
        }
    }    
}

//MARK: objc func
extension MainViewController{
    
    @objc func didTapEmergencyButton() {
        let nextVC = EmergencyViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func didTapPracticeButton() {
        let nextVC = PracticeViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func didTapExplanationButton() {
        let nextVC = ExplanationViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func didTapSettingButton() {
        let nextVC = SettingViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

//MARK: 오토레이아웃 영역
extension MainViewController{
    
    func setlayout(){
        view.addSubview(mapVeiw)
        mapVeiw.snp.makeConstraints{
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            //            $0.top.equalToSuperview()
            
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height / 3)
        }
        
        view.addSubview(exLabel)
        exLabel.snp.makeConstraints{
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(mapVeiw.snp.bottom).offset(8)
        }
        
        view.addSubview(mapLabel)
        mapLabel.snp.makeConstraints{
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(exLabel.snp.bottom).offset(8)
        }
        
        view.addSubview(testStackVeiw)
        testStackVeiw.snp.makeConstraints{
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height / 3)
        }
    }
    
}

//        locationManager.stopUpdatingLocation()
