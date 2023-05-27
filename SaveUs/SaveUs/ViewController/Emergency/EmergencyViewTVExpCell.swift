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
        $0.font = UIFont.boldSystemFont(ofSize: 25)
    }
    
    private lazy var titleTimerLabel: UILabel = .init().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 2
        $0.layer.masksToBounds = true
        $0.text = "10"
        $0.font = UIFont.boldSystemFont(ofSize: 17)
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
        $0.text = "0"
        $0.setLineSpacing(spacing: 4)
    }
    
    private lazy var des2Label: UILabel = .init().then{
        $0.font = UIFont.boldSystemFont(ofSize: 18)
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.text = "0"
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
        TTSManager.shared.stop()
        TTSManager.shared.play(data.voiceString)
        titleLabel.text = data.title
        des1Label.text = data.des1
        des2Label.text = data.des2
        
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
            $0.height.equalTo(64)
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
            $0.height.width.equalTo(40)
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



