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
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        //表示データの取得
        self.getData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myTableView.reloadData()
    }
    
    //データ取得
    func getData() {
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
            self.myTableView.reloadData()
        }
    }
    
    @IBAction func calcTotalTime(_ sender: UIBarButtonItem) {
        
        let alert: UIAlertController = UIAlertController(title: "累計飛行時間", message: "hh時間mm分ss秒", preferredStyle:  UIAlertController.Style.alert)

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
    
    @IBAction func addRecord(_ sender: UIBarButtonItem) {
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewModel.flightInfoArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell") ??
            UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = ViewModel.flightInfoArray[indexPath.row].droneName! + " " + ViewModel.flightInfoArray[indexPath.row].flightTime!
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
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        //選択した飛行情報のレコードIDを保持
//        let targetRecordID = flightInfoArray[indexPath.row].recordID!.description
//        //タップされたセルの色を通常色に戻す
//        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
//             myTableView.deselectRow(at: indexPathForSelectedRow, animated: true)
//        }
//        //タスク詳細画面に遷移
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
//        self.present(vc, animated: true, completion: nil)
//
//    }
}

