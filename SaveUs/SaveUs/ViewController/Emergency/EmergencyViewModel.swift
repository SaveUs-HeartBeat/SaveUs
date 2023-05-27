//
//  EmergencyViewModel.swift
//  SaveUs
//
//  Created by Ruyha on 2023/05/28.
//

import Foundation

class EmergencyViewModel {
    
    private var cellDateCount = 0
    private(set) var cellCurrentData: EmergencyViewTVCModel = .init(title: "", des1: "", des2: "")
    
    ///미리설정해 놓은 텍스트
    private  let EmergencyViewTVCModelArray = [
        EmergencyViewTVCModel(title: "환자 상태 파악",
                              des1: "1. 현장의 안전을 확인합니다.",
                              des2: "2. 환자의 어깨를 가볍게 두드리며 큰 목소리로 “괜찮으세요?”라고 물어보며 의식을 확인합니다."),
        
        EmergencyViewTVCModel(title: "구조 요청",
                              des1: "1. 큰 목소리로 주변사람의 인상착의를 통해 자세히 대상을 지목하며 119신고를 부탁합니다.",
                              des2: "2. 또 다른 주변 사람에게 동일한 방법으로 자동심장충격기(AED)를 요청합니다."),
        
        EmergencyViewTVCModel(title: "호흡 확인",
                              des1: "1. 환자의 얼굴과 가슴을 10초 이내로 관찰하여 호흡여부를 확인합니다.",
                              des2: "2. 환자의 호흡이 없거나 비정상적이라면 심정지가 발생한 것으로 가슴압박을 시행합니다."),
        
        EmergencyViewTVCModel(title: "가슴압박 시행",
                              des1: "1. 환자의 가슴 중앙에 깍지낀 두손으로 몸과 수직이 되도록  압박합니다.",
                              des2: "2. 다음 박자에 맞춰 가슴 압박을 시행하세요."),
    ]
    
    @discardableResult
    func setCellData() -> Bool {
        guard cellDateCount < EmergencyViewTVCModelArray.count else {
            return false
        }
        
        self.cellCurrentData = EmergencyViewTVCModelArray[cellDateCount]
        cellDateCount += 1
        
        if cellDateCount == EmergencyViewTVCModelArray.count {
            cellDateCount = EmergencyViewTVCModelArray.count - 1
            return true
        }
        
        return false
    }

    
    
    
    
}
