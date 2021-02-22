//
//  FlightInfo.swift
//  FlightManagement
//
//  Created by 小竹修平 on 2020/12/01.
//  Copyright © 2020 Shuhei Kotake. All rights reserved.
//

import Foundation
import FirebaseFirestore

class FlightInfo: NSObject {
    
    var recordID: Int?
    var userID: String?
    var operatorID: String?
    var droneName: String?
    var flightDate: String?
    var flightMode: String?
    var flightPlace: String?
    var flightTime: String?
    var memo: String?
    var timestamp: Date?

    init(document: QueryDocumentSnapshot) {
        
        let dic = document.data()
        self.recordID = dic["RecordID"] as? Int
        self.userID = dic["UserID"] as? String
        self.operatorID = dic["OperatorID"] as? String
        self.droneName = dic["DroneName"] as? String
        self.flightDate = dic["FlightDate"] as? String
        self.flightMode = dic["FlightMode"] as? String
        self.flightPlace = dic["FlightPlace"] as? String
        self.flightTime = dic["FlightTime"] as? String
        self.memo = dic["Memo"] as? String
        self.timestamp = dic["Timestamp"] as? Date
        
   }
}
