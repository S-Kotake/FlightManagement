//
//  OperatorInfo.swift
//  FlightManagement
//
//  Created by 小竹修平 on 2021/02/02.
//  Copyright © 2021 Shuhei Kotake. All rights reserved.
//

import Foundation
import FirebaseFirestore

class OperatorInfo: NSObject {
    
    var operatorID: Int?
    var operatorName: String?
    var skillLevel: String?

    init(document: QueryDocumentSnapshot) {
        
        let dic = document.data()

        self.operatorID = dic["OperatorID"] as? Int
        self.operatorName = dic["OperatorName"] as? String
        self.skillLevel = dic["SkillLevel"] as? String
   }
}
