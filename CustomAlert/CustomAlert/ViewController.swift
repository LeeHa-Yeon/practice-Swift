//
//  ViewController.swift
//  CustomAlert
//
//  Created by 이하연 on 2022/03/21.
//

import UIKit

class ViewController: UIViewController {
    
    var monthArr: [Int] = [1,2,3,4,5,6,7,8,9,10,11,12]
    
    @IBOutlet weak var testPickView: UIPickerView!
    
    @IBOutlet var mainView: UIView!
    
    @IBAction func testBtn(_ sender: Any) {
        let customView = AlertView(frame: view.bounds)
        customView.showAlert(firstBtnTitle: "취소", secondBtnTitle: "확인")
        view.addSubview(customView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testPickView.delegate = self
        testPickView.dataSource = self
    }


}


extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    // 피커뷰의 구성요소(컬럼) 수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // 높이
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    // 구성요소(컬럼)의 행수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return monthArr.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Goyang", size: 14)
            pickerLabel?.textAlignment = .center
        }
        
        pickerLabel?.text = "\(monthArr[row])월"
        
        return pickerLabel!
    }
    
    
    //     피커뷰에서 선택시 호출
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("dfdf")
        print(monthArr[row])
    }
    
    
    
}
