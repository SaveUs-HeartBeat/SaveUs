//
//  MainViewController.swift
//  SaveUs
//
//  Created by Ruyha on 2023/03/28.
//

import UIKit

import SnapKit

class MainViewController: UIViewController {
    
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
    
//MARK: 생명주기 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setlayout()
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
        view.addSubview(testStackVeiw)
        testStackVeiw.snp.makeConstraints{
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height / 3)
        }
    }
    
}
