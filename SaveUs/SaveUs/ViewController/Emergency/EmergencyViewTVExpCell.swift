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
    
    ///대충 메인뷰 같은 느낌 콘텐츠뷰에 바로 설정하면 이상하게됨
    private let conView: UIView = .init().then{
        $0.backgroundColor = .white
    }
    
//MARK: 상단 타이틀
    /// 상단 타이틀 나오는거
    private lazy var titleView: UIView = .init().then{
        $0.backgroundColor = UIColor(hex: "#FF4B4B")
        $0.roundCorners(cornerRadius: 16, maskedCorners: [.topLeft, .topRight])
        $0.layer.borderWidth = borderW
    }
    
    private lazy var titleLabel: UILabel = .init().then{
        $0.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    private lazy var titleTimerLabel: UILabel = .init().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 2
        $0.layer.masksToBounds = true
        $0.text = "10"
        $0.font = UIFont.boldSystemFont(ofSize: 13)
        $0.textAlignment = .center
    }
    
    
//MARK: 설명 나오는 부분
    ///설명나오는뷰
    private lazy var desView: UIView = .init().then{
        $0.backgroundColor = .white
        $0.roundCorners(cornerRadius: 16, maskedCorners: [.bottomLeft, .bottomRight])
        $0.layer.borderWidth = borderW
    }
    
    private lazy var des1Label: UILabel = .init().then{
        $0.font = UIFont.boldSystemFont(ofSize: 18)
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.text = "1. 청춘의 트고, 그러므로 밥을 원대하고, 것이다. 설레는 크고 위하여 원대하고, 넣는 없으면, 위하여 동력은 그리하였는가? 눈에 꽃이 풍부하게 과실이 있으며, 곳이 만물은 원질이 봄바람이다. 남는 예가 이상의 가는 가치를 끓는 이상의 쓸쓸하랴? 동력은 찾아다녀도, 투명하되 청춘을 따뜻한 심장의 바이며, 운다. 있으며, 우리의 희망의 영원히 운다."
        $0.setLineSpacing(spacing: 4)
    }
    
    private lazy var des2Label: UILabel = .init().then{
        $0.font = UIFont.boldSystemFont(ofSize: 18)
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.text = "2. 가치를 안고, 물방아 때문이다. 인간은 보이는 같은 이는 아니한 이것이야말로 미인을 말이다. 남는 피가 구하지 갑 봄바람이다. 같이, 고행을 소금이라 힘있다. 힘차게 전인 지혜는 길지 인생에 끓는다."
        $0.setLineSpacing(spacing: 4)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //데이터셋팅
    func setData(data:EmergencyViewTVCModel){
        titleLabel.text = data.title
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
        setTitleView()
        
        desView.snp.makeConstraints{
            $0.top.equalTo(titleView.snp.bottom).offset(-borderW)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        setDesView()

    }
    
    private func setTitleView(){
        titleView.addSubview(titleLabel)
        titleView.addSubview(titleTimerLabel)
        titleLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        titleTimerLabel.snp.makeConstraints{
            $0.height.width.equalTo(30)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    private func setDesView(){
        desView.addSubview(des1Label)
        desView.addSubview(des2Label)
        
        des1Label.snp.makeConstraints{
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        des2Label.snp.makeConstraints{
            $0.top.equalTo(des1Label.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-16)
        }
        
    }
    
    
}



