//
//  ViewController.swift
//  FlightManagement
//
//  Created by 小竹修平 on 2020/10/19.
//  Copyright © 2020 Shuhei Kotake. All rights reserved.
//

import UIKit
import FirebaseFirestore

class FlightInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIBarPositioningDelegate, UINavigationBarDelegate {

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var myNavigationBar: UINavigationBar!

    //取得対象のコレクションを指定
    let Ref = Firestore.firestore().collection("FlightInfo")
    var activityIndicatorView = UIActivityIndicatorView()
    var selectedDrone = ""
    var selectedMode = ""
    var flightPlace = ""
    var level = ""
     
    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.delegate = self
        myTableView.dataSource = self
        
        myNavigationBar.delegate = self
        let navItem : UINavigationItem = UINavigationItem(title: ViewModel.selectedOperatorName + "さんの飛行実績")
        navItem.hidesBackButton = true
        navItem.rightBarButtonItem = addButton
        navItem.leftBarButtonItem = cancelButton
        myNavigationBar.pushItem(navItem, animated: true)
        self.view.addSubview(myNavigationBar)
        
        //ロード中に表示するインジケータを設定
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .large
        activityIndicatorView.color = .darkGray
        view.addSubview(activityIndicatorView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //表示データの取得
        self.getFlightData()
        myTableView.reloadData()
    }
    
    //データ取得
    func getFlightData() {
        //インジケータ表示
        self.activityIndicatorView.startAnimating()
        
        //getDocumentsでデータを取得
        Ref.whereField("OperatorID", isEqualTo: ViewModel.selectedOperatorID).getDocuments(){ (querySnapshot, error) in
            if let error = error {
                print(error)
                return
            }
            //取得した各データを配列に入れ込む
            ViewModel.flightInfoArray = querySnapshot!.documents.map { document in
                let result = FlightInfo(document: document)
                return result
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.activityIndicatorView.stopAnimating()
                self.myTableView.reloadData()
            }
        }
    }
    
    @IBAction func calcTotalTime(_ sender: UIBarButtonItem) {
        
        var totalHours = 0
        var totalMinutes = 0
        var totalSeconds = 0
        var totalTime: String = ""
        
        for flightInfo in ViewModel.flightInfoArray {

            let separatedTime: [String] = flightInfo.flightTime!.components(separatedBy: ":")

            let hours: Int = Int(separatedTime[0])!
            let minutes: Int = Int(separatedTime[1])!
            let seconds: Int = Int(separatedTime[2])!
            
            totalSeconds = totalSeconds + seconds
            totalMinutes = totalMinutes + minutes
            totalHours = totalHours + hours

            if totalSeconds > 59 {
                totalMinutes = totalMinutes + 1
                totalSeconds = totalSeconds - 60
            }
            
            if totalMinutes > 59 {
                totalHours = totalHours + 1
                totalMinutes = totalMinutes - 60
            }

            totalTime = String(format: "%02d", totalHours) + "時間" + String(format: "%02d", totalMinutes) + "分" + String(format: "%02d", totalSeconds) + "秒"
        }
        
        let alert: UIAlertController = UIAlertController(title: ViewModel.selectedOperatorName + "さんの累計飛行時間", message: totalTime, preferredStyle:  UIAlertController.Style.alert)

        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
        })
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
        })

        alert.addAction(cancelAction)
        alert.addAction(defaultAction)

        present(alert, animated: true, completion: nil)
        
    }
    
    //テーブルの行数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ViewModel.flightInfoArray.count
    }

    //セルにデータを設定して返す
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell") ??
            UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "機体：" + ViewModel.flightInfoArray[indexPath.row].droneName! + " 飛行時間：" +  ViewModel.flightInfoArray[indexPath.row].flightTime!
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        
        return cell
    }
    
    //セルの編集を許可
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }

    //スワイプしたセルを削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
                
        //スワイプされたセルのレコードIDを保持
        let targetRecordID = ViewModel.flightInfoArray[indexPath.row].recordID!.description
        if editingStyle == UITableViewCell.EditingStyle.delete {
            //該当データをDB，表示用データ，テーブルから削除
            Ref.document(targetRecordID).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
            ViewModel.flightInfoArray.remove(at: indexPath.row)
            myTableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //選択した飛行情報のレコードIDを保持
        let targetRecordID = ViewModel.flightInfoArray[indexPath.row].recordID!
        //タップされたセルの色を通常色に戻す
         if let indexPathForSelectedRow = myTableView.indexPathForSelectedRow {
             myTableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
        
        //表示対象の飛行情報を取得
        for flightInfo in ViewModel.flightInfoArray {
            //タップした情報のレコードIDをもつ情報を抽出
            if flightInfo.recordID == targetRecordID {
                selectedDrone = flightInfo.droneName!
                selectedMode = flightInfo.flightMode!
                flightPlace = flightInfo.flightPlace!
            }
        }
        //タスク詳細画面に遷移
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditRecordView") as! EditRecordViewController
        if let nextVC = vc as? EditRecordViewController {
            nextVC.recordID = targetRecordID
            nextVC.selectedDrone = self.selectedDrone
            nextVC.selectedMode = self.selectedMode
            nextVC.flightPlace = self.flightPlace
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
         return .topAttached
    }
}

