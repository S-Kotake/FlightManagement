//
//  SetLevelViewController.swift
//  FlightManagement
//
//  Created by 小竹修平 on 2021/02/22.
//  Copyright © 2021 Shuhei Kotake. All rights reserved.
//

import UIKit

class SetLevelViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // trueで複数選択、falseで単一選択
        tableView.allowsMultipleSelection = false
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")

        cell.accessoryType = .checkmark
        
        return cell
    }
    
    //タップ時の処理
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at:indexPath)

        //セルが選択状態ではない場合
        if (cell?.accessoryType == UITableViewCell.AccessoryType.none) {
        //セルにチェックマークをつける
        cell?.accessoryType = .checkmark

        switch indexPath.section {
        //ホバリング項目
        case 0:
            switch indexPath.row {
            case 0:
                ViewModel.hovering_P_Forward = true
            case 1:
                ViewModel.hovering_P_Backward = true
            case 2:
                ViewModel.hovering_A_Forward = true
            case 3:
                ViewModel.hovering_A_Backward = true
            default:
                print("error")
            }
        case 1:
            switch indexPath.row {
            case 0:
                ViewModel.hovering_P_Forward = true
            case 1:
                ViewModel.hovering_P_Backward = true
            case 2:
                ViewModel.hovering_A_Forward = true
            case 3:
                ViewModel.hovering_A_Backward = true
            default:
                print("error")
            }
        case 2:
            switch indexPath.row {
            case 0:
                ViewModel.hovering_P_Forward = true
            case 1:
                ViewModel.hovering_P_Backward = true
            case 2:
                ViewModel.hovering_A_Forward = true
            case 3:
                ViewModel.hovering_A_Backward = true
            default:
                print("error")
            }
        case 3:
            switch indexPath.row {
            case 0:
                ViewModel.hovering_P_Forward = true
            case 1:
                ViewModel.hovering_P_Backward = true
            case 2:
                ViewModel.hovering_A_Forward = true
            case 3:
                ViewModel.hovering_A_Backward = true
            default:
                print("error")
            }
        case 4:
            switch indexPath.row {
            case 0:
                ViewModel.hovering_P_Forward = true
            case 1:
                ViewModel.hovering_P_Backward = true
            case 2:
                ViewModel.hovering_A_Forward = true
            case 3:
                ViewModel.hovering_A_Backward = true
            default:
                print("error")
            }
        case 5:
            switch indexPath.row {
            case 0:
                ViewModel.hovering_P_Forward = true
            case 1:
                ViewModel.hovering_P_Backward = true
            case 2:
                ViewModel.hovering_A_Forward = true
            case 3:
                ViewModel.hovering_A_Backward = true
            default:
                print("error")
            }
        default:
            print("Error")
        }
//        //基本移動
//        static var basic_P_UpDown_Forward = false
//        static var basic_P_UPDown_Backward = false
//        static var basic_A_UpDown_Forward = false
//        static var basic_A_UPDown_Backward = false
//        static var basic_P_FBLR_Forward = false
//        static var basic_P_FBLR_Backward = false
//        static var basic_A_FBLR_Forward = false
//        static var basic_A_FBLR_Backward = false
//        static var basic_P_diagonal_Forward = false
//        static var basic_P_diagonal_Backward = false
//        static var basic_A_diagonal_Forward = false
//        static var basic_A_diagonal_Backward = false
//
//        //高度変化移動
//        static var transAltitude_P_FBLR_Forward = false
//        static var transAltitude_P_FBLR_Backward = false
//        static var transAltitude_A_FBLR_Forward = false
//        static var transAltitude_A_FBLR_Backward = false
//        static var transAltitude_P_diagonal_Forward = false
//        static var transAltitude_P_diagonal_Backward = false
//        static var transAltitude_A_diagonal_Forward = false
//        static var transAltitude_A_diagonal_Backward = false
//
//        //水平ボックス
//        static var horizontalBox_P_Forward = false
//        static var horizontalBox_P_Heading = false
//        static var horizontalBox_P_Backward = false
//        static var horizontalBox_A_Forward = false
//        static var horizontalBox_A_Heading = false
//        static var horizontalBox_A_Backward = false
//
//        //垂直ボックス
//        static var verticalBox_P_Forward = false
//        static var verticalBox_P_Heading = false
//        static var verticalBox_P_Backward = false
//        static var verticalBox_A_Forward = false
//        static var verticalBox_A_Heading = false
//        static var verticalBox_A_Backward = false
//
//        //サークル
//        static var circle_P_Forward = false
//        static var circle_P_Heading = false
//        static var circle_P_NoseIn = false
//        static var circle_A_Forward = false
//        static var circle_A_Heading = false
//        static var circle_A_NoseIn = false

        }
    }
}
