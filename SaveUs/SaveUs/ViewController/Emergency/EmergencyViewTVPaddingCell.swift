//
//  EmergencyViewTVPaddingCell.swift
//  SaveUs
//
//  Created by Ruyha on 2023/05/27.
//


import UIKit
import Reusable
import SnapKit
import Then

class EmergencyViewTVPaddingCell: UITableViewCell, Reusable {

    
    var safeAreaHeight: CGFloat {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
            let safeAreaInsets = keyWindow.safeAreaInsets
            return keyWindow.bounds.height - safeAreaInsets.top - safeAreaInsets.bottom
        }
        return 0
    }
    
    private let testView: UIView = {
        let view = UIView()
        return view
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 

}


extension EmergencyViewTVPaddingCell {
    private func setView(){
        self.contentView.addSubview(testView)
        testView.snp.makeConstraints{
            $0.height.equalTo(safeAreaHeight*0.05)
            $0.leading.trailing.top.bottom.equalToSuperview()
        }

    }
}
