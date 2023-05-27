//
//  EmergencyViewTVC.swift
//  SaveUs
//
//  Created by Ruyha on 2023/05/27.
//
import UIKit
import Reusable
import SnapKit
import Then

class EmergencyViewTVExpCell: UITableViewCell, Reusable {
    
    //중복되는거 떄문에 지정
    private let borderW: CGFloat = 3
    
    //대충 메인뷰 같은 느낌
    private let conView: UIView = .init().then{
        $0.backgroundColor = .white
    }
    
    
    //상단
    private lazy var titleView: UIView = .init().then{
        $0.backgroundColor = UIColor(hex: "#FF4B4B")
        $0.roundCorners(cornerRadius: 16, maskedCorners: [.topLeft, .topRight])
        $0.layer.borderWidth = borderW
    }
    
    
    private lazy var desView: UIView = .init().then{
        
        $0.backgroundColor = .white
        $0.roundCorners(cornerRadius: 16, maskedCorners: [.bottomLeft, .bottomRight])
        $0.layer.borderWidth = borderW
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension EmergencyViewTVExpCell {
    private func setView(){
        contentView.addSubview(conView)

        conView.addSubview(titleView)
        conView.addSubview(desView)
        
        conView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        titleView.snp.makeConstraints{
            $0.height.equalTo(48)
            $0.top.leading.trailing.equalToSuperview()
        }
        
        desView.snp.makeConstraints{
            $0.height.equalTo(100)
            $0.top.equalTo(titleView.snp.bottom).offset(-borderW)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        
        
        
    }
}



