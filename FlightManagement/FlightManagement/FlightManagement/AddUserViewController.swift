//
//  AddUserViewController.swift
//  FlightManagement
//
//  Created by 小竹修平 on 2021/02/23.
//  Copyright © 2021 Shuhei Kotake. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Eureka

class AddUserViewController : FormViewController, UINavigationBarDelegate, UIBarPositioningDelegate {
    
    @IBOutlet weak var myNavigationBar: UINavigationBar!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    let Ref = Firestore.firestore().collection("OperatorInfo")
    var companyName = ""
    var operatorName = ""
    
    var operatorInfoArray: [OperatorInfo] = []
    var maxOperatorID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ナビゲーションバーに関する設定
        myNavigationBar.delegate = self
        let navItem : UINavigationItem = UINavigationItem(title: "ユーザー登録")
        navItem.hidesBackButton = true
        navItem.rightBarButtonItem = doneButton
        navItem.leftBarButtonItem = cancelButton
        myNavigationBar.pushItem(navItem, animated: true)
        self.view.addSubview(myNavigationBar)
        
        self.getOperatorData()
        print(self.operatorInfoArray.count)
        self.getOperatorID()
        
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
        
        //会社名
        let companyNameRow = TextRow("CompanyNameRowTag") {
            $0.title = "会社名"
            $0.placeholder = "会社名"
            //未入力の場合の設定値
            self.companyName = ""
            $0.onChange { row in
                if let value = row.value {
                    self.companyName = value
                }
            }
        }
        
        //ユーザー名
        let operatorNameRow = TextRow("OperatorNameRowTag") {
            $0.title = "操縦者名"
            $0.placeholder = "操縦者名"
            //未入力の場合の設定値
            self.operatorName = ""
            $0.onChange { row in
                if let value = row.value {
                    self.operatorName = value
                }
            }
        }
        
        let companyNameSection = Section("会社名")
        companyNameSection.append(companyNameRow)
        let operatorNameSection = Section("操縦者名")
        operatorNameSection.append(operatorNameRow)

        form.append(headerSection)
        form.append(companyNameSection)
        form.append(operatorNameSection)
        
    }
    
    //データ取得
    private func getOperatorData() {

        //getDocumentsでデータを取得
        Ref.getDocuments(){ (querySnapshot, error) in
            if let error = error {
                print(error)
                return
            }
            //取得した各データを配列に入れ込む
            self.operatorInfoArray = querySnapshot!.documents.map { document in
                let result = OperatorInfo(document: document)
                return result
            }
        }
    }
    
    //付与するレコードIDを更新
    func getOperatorID() {

        for operatorInfo in self.operatorInfoArray {
            if operatorInfo.operatorID! > self.maxOperatorID {
                self.maxOperatorID = operatorInfo.operatorID!
            }
            print(maxOperatorID)
        }
        self.maxOperatorID = self.maxOperatorID + 1
    }
    
    //飛行実績を保存
    func insertData() {
        
        Ref.document(self.maxOperatorID.description).setData([
            
            "OperatorID": self.maxOperatorID,
            "OperatorName": self.operatorName,
            "SkillLeval": ""
        
        ]) { error in
            if let error = error {
                print("操縦者情報の保存に失敗しました。")
                return
            }
            print("操縦者情報の保存に成功しました。")
        }
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {

        let alert: UIAlertController = UIAlertController(title: "保存", message: "保存してもよろしいですか？", preferredStyle:  UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            self.insertData()
            
            //画面を閉じる
            self.dismiss(animated: true, completion: nil)
        })
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
        })
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)

        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
    
        self.dismiss(animated: true, completion: nil)
    
    }
    
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
         return .topAttached
     }
    
    
}
