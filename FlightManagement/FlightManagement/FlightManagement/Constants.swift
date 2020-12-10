//
//  Constants.swift
//  FlightManagement
//
//  Created by 小竹修平 on 2020/10/19.
//  Copyright © 2020 Shuhei Kotake. All rights reserved.
//

import Foundation

class Constants: NSObject {
    
    static let droneName = ["Mavic mini","Mavic Air","Mavic 2 zoom","phantom 3","phantom 4","Inspire 2","Matrice 210"]
    static let flightMode = ["Pモード","Aモード","Sモード"]
    
    static let dateFormat = "yyyyMMdd"
    static let timestampFormat = "yyyyMMddHHmmss"
    
    static let locale: String = "en_US_POSIX"
    
    static let timeZone: String = "Asia/Tokyo"
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale(identifier: locale)
        formatter.timeZone = TimeZone(identifier: timeZone)
        return formatter
    }()
    
    static let timestampFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = timestampFormat
        formatter.locale = Locale(identifier: locale)
        formatter.timeZone = TimeZone(identifier: timeZone)
        return formatter
    }()
    
    
}
