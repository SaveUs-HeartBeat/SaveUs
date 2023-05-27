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
    
    enum tableIndex: Int, CaseIterable {
        case topPaddingCell
        case expCell
        case mapCell
    }
    
    private let tableView: UITableView = .init().then {
        $0.register(cellType: EmergencyViewTVPaddingCell.self)
        $0.register(cellType: EmergencyViewTVExpCell.self)
        $0.sectionHeaderTopPadding = 0.0
        $0.backgroundColor = .white//.yellow.withAlphaComponent(0.3)//.GrayScale.Gray05.color
        $0.separatorStyle = .none
        $0.sectionFooterHeight = 0
        $0.contentInsetAdjustmentBehavior = .never
    }
    
    private let bottomView: UIView = .init().then{
        $0.backgroundColor = .white
    }
    
    private lazy var endButton: UIButton = .init().then {
        $0.backgroundColor = UIColor(hex: "#B7B7B7")
        $0.setTitle("상황종료", for: .normal)
//        $0.setTitleColor(UIColor(hex: "#75808A"), for: .normal)
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private let bottomPaddingView: UIView = .init()
    
    private lazy var nextButton: UIButton = .init().then {
        $0.backgroundColor = UIColor(hex: "#F14C40")
        $0.setTitle("다음", for: .normal)
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
//        $0.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        ///nav설정하는거
        self.setNavbar(title: "실제 상황", titleColor: .red)
        setView()
    }
    
    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension EmergencyViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableIndex.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentIndex = tableIndex(rawValue: indexPath.section)
        switch currentIndex {
        case .topPaddingCell:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: EmergencyViewTVPaddingCell.self)
            return cell
        case .expCell:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: EmergencyViewTVExpCell.self)
            //        let giftBoxList = self.viewModel.giftBoxList
            //        cell.setData(giftBox: giftBoxList[indexPath.row])
            //        cell.isCellFirstAndLast(arrayCount: giftBoxList.count, indexPath: indexPath.row)
            //        cell.delegate = self
            return cell
            
        case .mapCell :
            return .init()
            
        case .none:
            return .init()
        }
        
    }
}

extension EmergencyViewController {
    
    private func setView(){
        view.addSubview(tableView)
        view.addSubview(bottomView)
//        endButton nextButton
        bottomView.addSubview(endButton)
        bottomView.addSubview(bottomPaddingView)
        bottomView.addSubview(nextButton)

        tableView.snp.makeConstraints{
            $0.top.equalTo(navBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomView)
        }
        
        bottomView.snp.makeConstraints{
            $0.height.equalTo(84)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        bottomPaddingView.snp.makeConstraints{
//            bottomPaddingView.backgroundColor = .red
            $0.height.equalTo(52)
            $0.width.equalTo(16)
            $0.center.equalToSuperview()
        }
        
        endButton.snp.makeConstraints{
            $0.height.equalTo(52)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(bottomPaddingView.snp.leading)
        }
        
        nextButton.snp.makeConstraints{
            $0.height.equalTo(52)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(bottomPaddingView.snp.trailing)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        
    }
    
}

