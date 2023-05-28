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


class EmergencyViewTVCallCell: UITableViewCell, Reusable {
    
    ///컨텐츠 들어갈 뷰
    private let conView: UIView = .init()
    
    ///신고버튼
    private lazy var call119Button: UIButton = .init().then {
        $0.backgroundColor = UIColor(hex: "#F14C40")
        $0.setTitle("119 신고", for: .normal)
        $0.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 20)
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.layer.borderWidth = 3
        $0.addTarget(self, action: #selector(call119ButtonTapped), for: .touchUpInside)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc
    private func call119ButtonTapped() {
        let number:Int = 119
        if let url = NSURL(string: "tel://" + "\(number)"),
            UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    
}

extension EmergencyViewTVCallCell {
    
    private func setView(){
        contentView.addSubview(conView)
        conView.addSubview(call119Button)

        conView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        call119Button.snp.makeConstraints{
            $0.height.equalTo(52)
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        
    }
    
}
