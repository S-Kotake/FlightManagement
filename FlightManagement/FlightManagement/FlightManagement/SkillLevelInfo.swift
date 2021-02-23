//
//  SkillLevelInfo.swift
//  FlightManagement
//
//  Created by 小竹修平 on 2021/02/23.
//  Copyright © 2021 Shuhei Kotake. All rights reserved.
//

import Foundation
import FirebaseFirestore

class SkillLevelInfo: NSObject {
    
    //ホバリング
    var hovering_P_Forward: Bool
    var hovering_P_Backward: Bool
    var hovering_A_Forward: Bool
    var hovering_A_Backward: Bool
    //基本移動
    var basic_P_UpDown_Forward: Bool
    var basic_P_UPDown_Backward: Bool
    var basic_A_UpDown_Forward: Bool
    var basic_A_UPDown_Backward: Bool
    var basic_P_FBLR_Forward: Bool
    var basic_P_FBLR_Backward: Bool
    var basic_A_FBLR_Forward: Bool
    var basic_A_FBLR_Backward: Bool
    var basic_P_diagonal_Forward: Bool
    var basic_P_diagonal_Backward: Bool
    var basic_A_diagonal_Forward: Bool
    var basic_A_diagonal_Backward: Bool
    //高度変化移動
    var transAltitude_P_FBLR_Forward: Bool
    var transAltitude_P_FBLR_Backward: Bool
    var transAltitude_A_FBLR_Forward: Bool
    var transAltitude_A_FBLR_Backward: Bool
    var transAltitude_P_diagonal_Forward: Bool
    var transAltitude_P_diagonal_Backward: Bool
    var transAltitude_A_diagonal_Forward: Bool
    var transAltitude_A_diagonal_Backward: Bool
    //水平ボックス
    var horizontalBox_P_Forward: Bool
    var horizontalBox_P_Heading: Bool
    var horizontalBox_P_Backward: Bool
    var horizontalBox_A_Forward: Bool
    var horizontalBox_A_Heading: Bool
    var horizontalBox_A_Backward: Bool
    //垂直ボックス
    var verticalBox_P_Forward: Bool
    var verticalBox_P_Heading: Bool
    var verticalBox_P_Backward: Bool
    var verticalBox_A_Forward: Bool
    var verticalBox_A_Heading: Bool
    var verticalBox_A_Backward: Bool
    //サークル
    var circle_P_Forward: Bool
    var circle_P_Heading: Bool
    var circle_P_NoseIn: Bool
    var circle_A_Forward: Bool
    var circle_A_Heading: Bool
    var circle_A_NoseIn: Bool

    init(document: QueryDocumentSnapshot) {
        
        let dic = document.data()
        //ホバリング
        self.hovering_P_Forward = dic["Hovering_P_Forward"] as! Bool
        self.hovering_P_Backward = dic["Hovering_P_Backward"] as! Bool
        self.hovering_A_Forward = dic["Hovering_A_Forward"] as! Bool
        self.hovering_A_Backward = dic["Hovering_A_Backward"] as! Bool
        //基本移動
        self.basic_P_UpDown_Forward = dic["Hovering_P_Forward"] as! Bool
        self.basic_P_UPDown_Backward = dic["Hovering_P_Backward"] as! Bool
        self.basic_A_UpDown_Forward = dic["Hovering_A_Forward"] as! Bool
        self.basic_A_UPDown_Backward = dic["Hovering_A_Backward"] as! Bool
        self.basic_P_FBLR_Forward = dic["Basic_P_FBLR_Forward"] as! Bool
        self.basic_P_FBLR_Backward = dic["Basic_P_FBLR_Backward"] as! Bool
        self.basic_A_FBLR_Forward = dic["Basic_A_FBLR_Forward"] as! Bool
        self.basic_A_FBLR_Backward = dic["Basic_A_FBLR_Backward"] as! Bool
        self.basic_P_diagonal_Forward = dic["Basic_P_diagonal_Forward"] as! Bool
        self.basic_P_diagonal_Backward = dic["Basic_P_diagonal_Backward"] as! Bool
        self.basic_A_diagonal_Forward = dic["Basic_A_diagonal_Forward"] as! Bool
        self.basic_A_diagonal_Backward = dic["Basic_A_diagonal_Backward"] as! Bool
        //高度変化移動
        self.transAltitude_P_FBLR_Forward = dic["TransAltitude_P_FBLR_Forward"] as! Bool
        self.transAltitude_P_FBLR_Backward = dic["TransAltitude_P_FBLR_Backward"] as! Bool
        self.transAltitude_A_FBLR_Forward = dic["TransAltitude_A_FBLR_Forward"] as! Bool
        self.transAltitude_A_FBLR_Backward = dic["TransAltitude_A_FBLR_Backward"] as! Bool
        self.transAltitude_P_diagonal_Forward = dic["TransAltitude_P_diagonal_Forward"] as! Bool
        self.transAltitude_P_diagonal_Backward = dic["TransAltitude_P_diagonal_Backward"] as! Bool
        self.transAltitude_A_diagonal_Forward = dic["TransAltitude_A_diagonal_Forward"] as! Bool
        self.transAltitude_A_diagonal_Backward = dic["TransAltitude_A_diagonal_Backward"] as! Bool
        //水平ボックス
        self.horizontalBox_P_Forward = dic["HorizontalBox_P_Forward"] as! Bool
        self.horizontalBox_P_Heading = dic["HorizontalBox_P_Heading"] as! Bool
        self.horizontalBox_P_Backward = dic["HorizontalBox_P_Backward"] as! Bool
        self.horizontalBox_A_Forward = dic["HorizontalBox_A_Forward"] as! Bool
        self.horizontalBox_A_Heading = dic["HorizontalBox_A_Heading"] as! Bool
        self.horizontalBox_A_Backward = dic["HorizontalBox_A_Backward"] as! Bool
        //垂直ボックス
        self.verticalBox_P_Forward = dic["VerticalBox_P_Forward"] as! Bool
        self.verticalBox_P_Heading = dic["VerticalBox_P_Heading"] as! Bool
        self.verticalBox_P_Backward = dic["VerticalBox_P_Backward"] as! Bool
        self.verticalBox_A_Forward = dic["VerticalBox_A_Forward"] as! Bool
        self.verticalBox_A_Heading = dic["VerticalBox_A_Heading"] as! Bool
        self.verticalBox_A_Backward = dic["VerticalBox_A_Backward"] as! Bool
        //サークル
        self.circle_P_Forward = dic["Circle_P_Forward"] as! Bool
        self.circle_P_Heading = dic["Circle_P_Heading"] as! Bool
        self.circle_P_NoseIn = dic["Circle_P_NoseIn"] as! Bool
        self.circle_A_Forward = dic["Circle_A_Forward"] as! Bool
        self.circle_A_Heading = dic["Circle_A_Heading"] as! Bool
        self.circle_A_NoseIn = dic["Circle_A_NoseIn"] as! Bool
   }
}
