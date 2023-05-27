//
//  CustomNavBar.swift
//  SaveUs
//
//  Created by Ruyha on 2023/05/27.
//

import UIKit
import SnapKit


final class CustomNavBar : UIView {
    
    var didTpaBackButton: (() -> ())?

    private(set) lazy var backButtonImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "backbtnImage")
        return view
    }()
    
    private(set) lazy var backButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    func setView(title:String,titleColor:UIColor, backColor:UIColor ){
        self.titleLabel.text = title
        self.backgroundColor = backColor
        self.titleLabel.tintColor = titleColor
        setView()
    }
    
    
    @objc
    private func backButtonTapped() {
        self.didTpaBackButton?()
    }
    
}

//MARK: 오토레이아웃 영역
extension CustomNavBar {
 
    private func setView(){
        self.addSubview(backButton)
        self.addSubview(titleLabel)
        backButton.addSubview(backButtonImageView)
        
        backButton.snp.makeConstraints{
            $0.height.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.3)
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        backButtonImageView.snp.makeConstraints{
            $0.width.height.equalTo(24)
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
}
