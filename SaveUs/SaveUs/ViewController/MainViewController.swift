//
//  MainViewController.swift
//  SaveUs
//
//  Created by Ruyha on 2023/03/28.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "SaveUs"
        label.font = UIFont.systemFont(ofSize: 48)
        label.textAlignment = .center
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emergencyView,mainStackView])
        stackView.axis = .vertical // 가로로 배치
        stackView.distribution = .fillEqually // 뷰들을 동일한 크기로 조정
        stackView.spacing = 32 // 뷰 사이의 간격을 16으로 설정
        return stackView
    }()
    
    
    private let emergencyView: UIView = {
        let view = UIView()
        return view
    }()
    
    /// 실제상황 //mainButtonimage
    private lazy var emergencyButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapEmergencyButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var emergencyImageView : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "mainButtonimage")
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var  mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [practiceButton,subStackeiw])
        stackView.axis = .horizontal // 가로로 배치
        stackView.alignment = .fill // 뷰의 크기를 동일하게 유지
        stackView.spacing = 16 // 뷰 사이의 간격을 16으로 설정
        return stackView
    }()
    
    ///연습모드
    private lazy var practiceButton: UIButton = {
        let button = UIButton()
        button.setTitle("연습모드",for:.normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(hex: "#FFE600")
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 2
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25) // 볼드 폰트로 설정
        button.addTarget(self, action: #selector(didTapPracticeButton), for: .touchUpInside)
        return button
    }()

    private lazy var subStackeiw: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [explanationButton,settingButton])
        stackView.axis = .vertical // 가로로 배치
        stackView.distribution = .fillEqually // 뷰들을 동일한 크기로 조정
        stackView.spacing = 8 // 뷰 사이의 간격을 16으로 설정
        return stackView
    }()

    //설명화면
    private lazy var explanationButton: UIButton = {
        let button = UIButton()
        button.setTitle("explanationButton",for:.normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(didTapExplanationButton), for: .touchUpInside)
        return button
    }()
    
    //셋팅화면
    private lazy var settingButton: UIButton = {
        let button = UIButton()
        button.setTitle("settingButton",for:.normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(didTapSettingButton), for: .touchUpInside)
        return button
    }()

    //MARK: 생명주기 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        setLayout()
        startAnimation()
        navigationController?.navigationBar.backgroundColor = .red
        
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
    
    
    func startAnimation() {
        let animationDuration = 60.0 / 110.0 // 1분에 55번 동작하도록 설정
         
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: [.autoreverse, .repeat], animations: {
            self.emergencyImageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: nil)
        
    }

    // 애니메이션을 중지하는 함수
    func stopAnimation() {
        emergencyImageView.layer.removeAllAnimations()
    }
    
}

//MARK: 오토레이아웃 영역
extension MainViewController{
    
    func setLayout(){
        
        emergencyView.addSubview(emergencyImageView)
        emergencyView.addSubview(emergencyButton)
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(50)
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-48)
        }
        
        
        emergencyButton.snp.makeConstraints{
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        emergencyImageView.snp.makeConstraints{
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
    }
    
    
}
