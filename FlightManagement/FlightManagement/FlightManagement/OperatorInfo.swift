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
    
    var operatorID: String?
    var operatorName: String?

    init(document: QueryDocumentSnapshot) {
        
        let dic = document.data()

        self.operatorID = dic["OperatorID"] as? String
        self.operatorName = dic["OperatorName"] as? String
   }
}
