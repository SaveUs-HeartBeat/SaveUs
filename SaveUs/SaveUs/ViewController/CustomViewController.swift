//
//  CustomViewController.swift
//  SaveUs
//
//  Created by Ruyha on 2023/05/27.
//

import UIKit
import SnapKit

class CustomViewController: UIViewController {

    let navBar : CustomNavBar = {
       let view = CustomNavBar()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navBar.didTpaBackButton = {
            self.navigationController?.popViewController(animated: true)
            TTSManager.shared.stop()
        }
        setView()
    }

    func setNavbar(title:String, titleColor:UIColor,backColor:UIColor = .white){
        navBar.setView(title: title, titleColor: titleColor,backColor: backColor)
    }
}

extension CustomViewController {
    private func setView(){
        view.addSubview(navBar)
        navBar.snp.makeConstraints{
            $0.height.equalTo(56)
            $0.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
