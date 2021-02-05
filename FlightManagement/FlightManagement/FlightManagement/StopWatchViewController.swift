//
//  StopWatchViewController.swift
//  FlightManagement
//
//  Created by 小竹修平 on 2020/10/19.
//  Copyright © 2020 Shuhei Kotake. All rights reserved.
//

import UIKit
import FirebaseFirestore

class StopWatchViewController: UIViewController {
    
    //全画面からの引き継ぎ値
    var selectedDrone = ""
    var selectedMode = ""
    var flightPlace = ""
    var flightTime = ""
    
    var isRunning = false
    var getDateFlg = false
    var timer: Timer?
    var timeForDisplay: Int = 0
    
    var recordID: String = ""
    
    //飛行開始・終了時刻
    var startDate = ""
    var endDate = ""
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hourLabel.adjustsFontSizeToFitWidth = true
        minuteLabel.adjustsFontSizeToFitWidth = true
        secondLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        saveButton.isEnabled = false
        resetButton.isEnabled = false
    }
    
    //タイマーの状態を切り替える
    @IBAction func switchTimer(_ sender: UIButton) {
        //ストップウォッチを開始(再開)
        if !isRunning {
            
            if !getDateFlg {
            
                startDate = Constants.recordDateFormatter.string(from: Date())
                getDateFlg = true
            }
            
            
            timer = Timer()
            //スケジュール重複を防ぐ
            guard timer == nil else { return }
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(calcTimeForDisplay), userInfo: nil, repeats: true)
            
            isRunning = true
            
            //ボタン制御
            startButton.setTitle("stop", for: .normal)
            startButton.tintColor = .red
            resetButton.isEnabled = false
            saveButton.isEnabled = false

        //ストップウォッチを停止
        } else {
            endDate = Constants.recordDateFormatter.string(from: Date())
            //タイマーのインスタンスを破棄
            timer?.invalidate()
            
            isRunning = false
            
            //ボタン制御
            startButton.setTitle("start", for: .normal)
            startButton.tintColor = .blue
            saveButton.isEnabled = true
            resetButton.isEnabled = true
        }
    }

    //ストップウォッチをリセット
    @IBAction func resetTimer(_ sender: UIButton) {
        timer?.invalidate()
        timeForDisplay = 0
        hourLabel.text = "00"
        minuteLabel.text = "00"
        secondLabel.text = "00"
        
        getDateFlg = false
    }
    
    //表示用の時間を計算するメソッド
    @objc func calcTimeForDisplay() {
        timeForDisplay = timeForDisplay + 1
        var hour = Int(timeForDisplay / 3600)
        var minute = Int((timeForDisplay % 3600) / 60)
        var second = Int((timeForDisplay % 3600) % 60)
        
        //くり上がり計算
        if second > 59 {
            second = 0
            minute = minute + 1
        }
        if minute > 59 {
            minute = 0
            hour = hour + 1
        }
        if hour > 99 {
            hour = 99
        }
  
        //表示用の設定。２ケタのゼロ埋め
        hourLabel.text = String(format: "%02d", hour)
        minuteLabel.text =  String(format: "%02d", minute)
        secondLabel.text =  String(format: "%02d", second)
        flightTime = hourLabel.text! + ":" + minuteLabel.text! + ":" + secondLabel.text!
    }
    
    @IBAction func save(_ sender: UIButton) {
    
        let alert: UIAlertController = UIAlertController(title: "保存", message: "保存してもよろしいですか？", preferredStyle:  UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            
            self.getDateFlg = false
            //レコードIDを発行
            self.getRecordID()
            
            //データを保存
            self.insertData()
            
            //画面を閉じる
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        })
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
        })
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)

        present(alert, animated: true, completion: nil)
    
    }

    //飛行実績を保存
    func insertData() {
        
        let db = Firestore.firestore()
        db.collection("FlightInfo").document(ViewModel.maxRecordID.description).setData([
            "RecordID": ViewModel.maxRecordID,
            "OperatorID": ViewModel.selectedOperatorID,
            "DroneName": selectedDrone,
            "FlightDate": Constants.dateFormatter.string(from: Date()),
            "FlightMode": selectedMode,
            "FlightPlace": flightPlace,
            "FlightStartTime": startDate,
            "FlightEndTime": endDate,
            "FlightTime": flightTime,
            "Timestamp": FieldValue.serverTimestamp()
        
        ]) { error in
            if let error = error {
                print("記録の保存に失敗しました。")
                return
            }
            print("記録の保存に成功しました。")
        }
    }
    
    //付与するレコードIDを更新
    func getRecordID() {

        for flightInfo in ViewModel.flightInfoArray {
            if flightInfo.recordID! > ViewModel.maxRecordID {
                ViewModel.maxRecordID = flightInfo.recordID!
            }
        }
        ViewModel.maxRecordID = ViewModel.maxRecordID + 1
    }
}
