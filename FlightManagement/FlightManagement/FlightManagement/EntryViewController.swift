//
//  EntryViewController.swift
//  FlightManagement
//
//  Created by 小竹修平 on 2020/10/19.
//  Copyright © 2020 Shuhei Kotake. All rights reserved.
//

import UIKit
import Eureka

class EntryViewController : FormViewController, UINavigationBarDelegate, UIBarPositioningDelegate {
    
    var selectedDrone: String = ""
    var selectedMode: String = ""
    var flightPlace: String = ""
    @IBOutlet weak var myNavigationBar: UINavigationBar!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ナビゲーションバーに関する設定
        myNavigationBar.delegate = self
        let navItem : UINavigationItem = UINavigationItem(title: "飛行情報入力")
        navItem.hidesBackButton = true
        navItem.rightBarButtonItem = doneButton
        navItem.leftBarButtonItem = cancelButton
        myNavigationBar.pushItem(navItem, animated: true)
        self.view.addSubview(myNavigationBar)
        
        //ヘッダの設定
        let headerSection = Section(){ section in
            section.header = {
                  var header = HeaderFooterView<UIView>(.callback({
                      let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                      view.backgroundColor = .clear
                      return view
                  }))
                  header.height = { 50 }
                  return header
                }()
        }
        
        //機体名
        let droneNameRow = PushRow<String>("DromeNameRowTag") {
            $0.title = "機体名"
            $0.value = Constants.droneName[0]
            $0.options = Constants.droneName
            //未選択の場合はリスト先頭の機体名を設定する
            self.selectedDrone = $0.value!
            $0.onChange { row in
                //値が変更されなかった場合，元の値を設定
                if row.value == nil {
                    row.value = self.selectedDrone
                    row.reload()
                //値が変更された場合，変更後の値を設定
                } else {
                    self.selectedDrone = row.value!
                }
            }
            $0.onPresent { form, selectorController in
                        selectorController.enableDeselection = false
            }
        }
        
        //飛行モード
        let flightModeRow = PushRow<String>("FlightModeRowTag") {
            $0.title = "飛行モード"
            $0.value = Constants.flightMode[0]
            $0.options = Constants.flightMode
            //未選択の場合の設定値
            self.selectedMode = $0.value!
            $0.onChange { row in
                //値が変更されなかった場合，元の値を設定
                if row.value == nil {
                    row.value = self.selectedMode
                    row.reload()
                //値が変更された場合，変更後の値を設定
                } else {
                    self.selectedMode = row.value!
                }
            }
            $0.onPresent { form, selectorController in
                        selectorController.enableDeselection = false
            }
        }
        
        //飛行場所
        let flightPlaceRow = TextRow("FlightPlaceRowTag") {
            $0.title = "飛行場所"
            $0.placeholder = "飛行場所"
            //未入力の場合の設定値
            self.flightPlace = ""
            $0.onChange { row in
                if let value = row.value {
                    self.flightPlace = value
                }
            }
        }

        let droneNameSection = Section("機体名")
        droneNameSection.append(droneNameRow)
        let flightModeSection = Section("飛行モード")
        flightModeSection.append(flightModeRow)
        let flightPlaceSection = Section("飛行場所")
        flightPlaceSection.append(flightPlaceRow)

        form.append(headerSection)
        form.append(droneNameSection)
        form.append(flightModeSection)
        form.append(flightPlaceSection)
        
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        //入力値の取得
        self.selectedDrone = (form.rowBy(tag: "DromeNameRowTag") as! PushRow<String>).value!
        self.selectedMode = (form.rowBy(tag: "FlightModeRowTag") as! PushRow<String>).value!
        self.flightPlace = (form.rowBy(tag: "FlightPlaceRowTag") as! TextRow).value!
        
        self.performSegue(withIdentifier: "toStopWatchView", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStopWatchView" {
            let nextVC = segue.destination as! StopWatchViewController
            nextVC.selectedDrone = self.selectedDrone
            nextVC.selectedMode = self.selectedMode
            nextVC.flightPlace = self.flightPlace
        }
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
         return .topAttached
     }
}
