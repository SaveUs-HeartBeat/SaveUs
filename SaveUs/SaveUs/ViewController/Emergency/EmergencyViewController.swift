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
import AVFoundation


class EmergencyViewController: CustomViewController {
    
    ///소리재생하는애
    private var player: AVAudioPlayer?
    
    ///CPR소리재생가능 상태
    private var isBeepSoundPlay = false
    
    enum tableIndex: Int, CaseIterable {
        case topPaddingCell
        case expCell
        case callCell
        case mapCell
        case bottomPaddingCell

    }
    
    private let tableView: UITableView = .init().then {
        $0.register(cellType: EmergencyViewTVPaddingCell.self)
        $0.register(cellType: EmergencyViewTVExpCell.self)
        $0.register(cellType: EmergencyViewTVCallCell.self)
        $0.register(cellType: EmergencyViewTVMapCell.self)

        $0.sectionHeaderTopPadding = 0.0
        $0.backgroundColor = .white
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
        $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    private let viewModel = EmergencyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        ///nav설정하는거
        self.setNavbar(title: "실제 상황", titleColor: .red)
        self.viewModel.setCellData()
        setView()
        setCloser()
    }
    
    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
        TTSManager.shared.stop()
        self.stopSound()
        isBeepSoundPlay = false
        //이때는 재생 ㄴㄴ
    }
    
    @objc
    private func nextButtonTapped() {
        setNext()
    }
    
    private func startNext(){
        setNext()
        if self.isBeepSoundPlay {
            self.playSound()
            return
        }
    }

    private func setNext() {
        if self.viewModel.setCellData() {
            nextButton.backgroundColor = UIColor(hex: "#B7B7B7")
            nextButton.isEnabled = false
            self.isBeepSoundPlay = true
        }
        tableView.reloadData()
    }
    
    private func setCloser() {
        self.navBar.didTpaBackButton = {
            self.navigationController?.popViewController(animated: true)
            TTSManager.shared.stop()
            self.stopSound()
            self.isBeepSoundPlay = false
        }
        ///tts 재생끝 
//        TTSManager.shared.completion = {
//            print("ppap::ㅇ")
//            if self.isBeepSoundPlay {
//                self.playSound()
//                return
//            }
////            self.setNext()
//
//        }
        
        
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
            cell.setData(data: self.viewModel.cellCurrentData)
            cell.voicEnd = {
//                self.startNext()
                print("ppap : 보이스 끝남")
//                self.setNext()
            }
            return cell
            
        case .callCell :
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: EmergencyViewTVCallCell.self)
            return cell
            
        case .mapCell :
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: EmergencyViewTVMapCell.self)
//            cell.setData(data: self.viewModel.cellCurrentData)
            return cell
        case .bottomPaddingCell:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: EmergencyViewTVPaddingCell.self)
            return cell
            
        case .none:
            return .init()
        }
        
    }
}

extension EmergencyViewController {
    
    func playSound() {
        let soundName = "beep1"
        // forResource: 파일 이름(확장자 제외) , withExtension: 확장자(mp3, wav 등) 입력
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            player?.numberOfLoops = -1
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func stopSound() {
        player?.stop()
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
            $0.bottom.equalTo(bottomView.snp.top)
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

