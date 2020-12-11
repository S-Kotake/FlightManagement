//
//  ViewController.swift
//  FlightManagement
//
//  Created by 小竹修平 on 2020/10/19.
//  Copyright © 2020 Shuhei Kotake. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myTableView: UITableView!
    //取得対象のコレクションを指定
    let Ref = Firestore.firestore().collection("FlightInfo")
    var activityIndicatorView = UIActivityIndicatorView()
    
    var sectionArray: [String] = []
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .large
        activityIndicatorView.color = .darkGray

        view.addSubview(activityIndicatorView)
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //表示データの取得
        self.getData()
        //self.makeSections()
        myTableView.reloadData()
    }
    
    //データ取得
    func getData() {
        
        self.activityIndicatorView.startAnimating()
        //getDocumentsでデータを取得
        Ref.getDocuments() { (querySnapshot, error) in
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
    
//    func makeSections() {
//
//        var flightDate = ""
//
//        for flightInfo in ViewModel.flightInfoArray {
//            flightDate = flightInfo.flightDate!
//            //重複なくセクション名を抽出
//            if !sectionArray.contains(flightDate) {
//                sectionArray.append(flightDate)
//            }
//        }
//        print(sectionArray)
//    }
    
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
        
        let alert: UIAlertController = UIAlertController(title: "あなたの累計飛行時間", message: totalTime, preferredStyle:  UIAlertController.Style.alert)

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
    
//    //セクションの数を返す
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//
//        return sectionArray.count
//    }
//
//    //セクションのタイトルを返す
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//        return sectionArray[section]
//    }
    
    //テーブルの行数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ViewModel.flightInfoArray.count
    }

    //セルにデータを設定して返す
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell") ??
            UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "機体：" + ViewModel.flightInfoArray[indexPath.row].droneName! + " 飛行時間：" +  ViewModel.flightInfoArray[indexPath.row].flightTime!
        
        //if indexPath.section == ViewModel.flightInfoArray[indexPath.row].flightDate {
        //    cell.textLabel?.text = "機体：" + ViewModel.flightInfoArray[indexPath.row].droneName! + " 飛行時間：" +  ViewModel.flightInfoArray[indexPath.row].flightTime!
        //}
        
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
        let targetRecordID = ViewModel.flightInfoArray[indexPath.row].recordID!.description
        //タップされたセルの色を通常色に戻す
         if let indexPathForSelectedRow = myTableView.indexPathForSelectedRow {
             myTableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
        //タスク詳細画面に遷移
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
//        self.present(vc, animated: true, completion: nil)

    }
}

