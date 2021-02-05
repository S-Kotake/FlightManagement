//
//  LoginViewController.swift
//  FlightManagement
//
//  Created by 小竹修平 on 2021/02/02.
//  Copyright © 2021 Shuhei Kotake. All rights reserved.
//

import UIKit
import FirebaseFirestore

class StartViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var operatorNameForm: UITextField!
    @IBOutlet weak var startButton: UIButton!
    var pickerView = UIPickerView()
    
    let Ref = Firestore.firestore().collection("OperatorInfo")
    var operatorInfoArray: [OperatorInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ViewModel.selectedOperatorID = ""
        ViewModel.selectedOperatorName = ""
        
        operatorNameForm.delegate = self
        operatorNameForm.layer.borderWidth = 0.5
        operatorNameForm.layer.borderColor = UIColor(red: 94, green: 94, blue: 94, alpha: 0).cgColor
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        startButton.backgroundColor = .systemGray5
        startButton.isEnabled = false
        
        //表示用の操縦者情報を取得する
        self.getOperatorData()
        //ピッカービューにデータを設定
        self.createPickerView()

    }
    
    //データ取得
    private func getOperatorData() {

        //getDocumentsでデータを取得
        Ref.getDocuments() { (querySnapshot, error) in
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
    
    func createPickerView() {
        operatorNameForm.inputView = pickerView
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
        let doneButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePicker))
        let toolbarButtonGap = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([toolbarButtonGap, doneButtonItem], animated: true)
        operatorNameForm.inputAccessoryView = toolbar
    }
    
    
    @IBAction func endEdit(_ sender: UITextField) {
    
        if sender.text == "" {
            startButton.isEnabled = false
            startButton.backgroundColor = .systemGray5
        } else {
            startButton.isEnabled = true
            startButton.backgroundColor = .systemTeal
//            startButton.backgroundColor = UIColor(red: 0, green: 40, blue: 100, alpha: 1)
//            startButton.layer.borderWidth = 0.5
//            startButton.layer.borderColor = UIColor(red: 50, green: 165, blue: 230, alpha: 1).cgColor
        }
    }

    @objc func donePicker() {
        operatorNameForm.endEditing(true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        operatorNameForm.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.operatorInfoArray.count + 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if row == 0 {
            return ""
        } else {
            return self.operatorInfoArray[row - 1].operatorName
        }
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row != 0 {
            operatorNameForm.text = operatorInfoArray[row - 1].operatorName
            ViewModel.selectedOperatorID = operatorInfoArray[row - 1].operatorID!
            ViewModel.selectedOperatorName = operatorInfoArray[row - 1].operatorName!
        }
    }

}

class CustomTextField: UITextField {

    // 入力カーソル非表示
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    // 範囲選択カーソル非表示
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        return []
    }

    // コピー・ペースト・選択等のメニュー非表示
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }

}
