//
//  ViewModel.swift
//  FlightManagement
//
//  Created by 小竹修平 on 2020/10/19.
//  Copyright © 2020 Shuhei Kotake. All rights reserved.
//

import Foundation

class ViewModel: NSObject {
    
    static var maxRecordID = 0
    static var selectedOperatorID = ""
    static var selectedOperatorName = ""
    static var flightInfoArray: [FlightInfo] = []
    
    
    //レベル手入力
    static var memo = ""
    
    
    //レベル設定画面用項目
    //ホバリング
    static var hovering_P_Forward = false
    static var hovering_P_Backward = false
    static var hovering_A_Forward = false
    static var hovering_A_Backward = false
    
    //基本移動
    static var basic_P_UpDown_Forward = false
    static var basic_P_UPDown_Backward = false
    static var basic_A_UpDown_Forward = false
    static var basic_A_UPDown_Backward = false
    static var basic_P_FBLR_Forward = false
    static var basic_P_FBLR_Backward = false
    static var basic_A_FBLR_Forward = false
    static var basic_A_FBLR_Backward = false
    static var basic_P_diagonal_Forward = false
    static var basic_P_diagonal_Backward = false
    static var basic_A_diagonal_Forward = false
    static var basic_A_diagonal_Backward = false
    
    //高度変化移動
    static var transAltitude_P_FBLR_Forward = false
    static var transAltitude_P_FBLR_Backward = false
    static var transAltitude_A_FBLR_Forward = false
    static var transAltitude_A_FBLR_Backward = false
    static var transAltitude_P_diagonal_Forward = false
    static var transAltitude_P_diagonal_Backward = false
    static var transAltitude_A_diagonal_Forward = false
    static var transAltitude_A_diagonal_Backward = false

    //水平ボックス
    static var horizontalBox_P_Forward = false
    static var horizontalBox_P_Heading = false
    static var horizontalBox_P_Backward = false
    static var horizontalBox_A_Forward = false
    static var horizontalBox_A_Heading = false
    static var horizontalBox_A_Backward = false
    
    //垂直ボックス
    static var verticalBox_P_Forward = false
    static var verticalBox_P_Heading = false
    static var verticalBox_P_Backward = false
    static var verticalBox_A_Forward = false
    static var verticalBox_A_Heading = false
    static var verticalBox_A_Backward = false
    
    //サークル
    static var circle_P_Forward = false
    static var circle_P_Heading = false
    static var circle_P_NoseIn = false
    static var circle_A_Forward = false
    static var circle_A_Heading = false
    static var circle_A_NoseIn = false
}
