//
//  EmergencyViewController.swift
//  SaveUs
//
//  Created by Ruyha on 2023/03/28.
//

import UIKit
import Reusable
import SnapKit
import Then


class EmergencyViewController: CustomViewController {

    private lazy var recdivedGitboxTabelView: UITableView = .init().then {
//        $0.register(cellType: ReceivedGiftBoxTableViewCell.self)
        if #available(iOS 15.0, *) {
            $0.sectionHeaderTopPadding = 0.0
        }
        $0.backgroundColor = .white//.GrayScale.Gray05.color
        $0.separatorStyle = .none
        $0.sectionFooterHeight = 0
        $0.contentInsetAdjustmentBehavior = .never
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///nav설정하는거
        self.setNavbar(title: "실제 상황", titleColor: .red)
    }

}

