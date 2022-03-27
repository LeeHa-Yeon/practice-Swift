//
//  AlertView.swift
//  CustomAlert
//
//  Created by 이하연 on 2022/03/22.
//

import UIKit


class AlertView: UIView {
    
    public var delegate: AlertViewDelegate?
    
    var yearArr: [Int] = [2021,2022,2023]
    var monthArr: [Int] = [1,2,3,4,5,6,7,8,9,10,11,12]
    var testUIView: UIView!
    
    @IBOutlet var customView: UIView!
    @IBOutlet weak var yearPickerView: UIPickerView!
    @IBOutlet weak var monthPickerView: UIPickerView!
    
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var cancleButton: UIButton!
    @IBOutlet weak var okButton: UIButton!

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override func layoutSubviews() {
        setPickerView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    @IBAction func closeTapped(_ sender: UIButton) {
        self.delegate?.cancleButtonTapped(sender, testUIView)
        print("이이이")
    }
    
    @IBAction func okTapped(_ sender: UIButton) {
        self.delegate?.okButtonTapped(sender,testUIView)
        print("해해해해")
    }

    
    
    // autoresizingMask로 모든 화면에 맞춰줌
    private func commonInit() {
        
        Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)
        
        cancleButton.layer.borderWidth = 0.5
        cancleButton.layer.borderColor = UIColor.lightGray.cgColor
        
        okButton.layer.borderWidth = 0.5
        okButton.layer.borderColor = UIColor.lightGray.cgColor
        
        customView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        customView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(customView)
    }
    
    func setPickerView(){
        
        yearPickerView.delegate = self
        yearPickerView.dataSource = self
        monthPickerView.delegate = self
        monthPickerView.dataSource = self
        selectedPickerViewUICustom(yearPickerView)
        selectedPickerViewUICustom(monthPickerView)
    }
    
    func selectedPickerViewUICustom(_ selectedPickerView: UIPickerView) {
        selectedPickerView.subviews[1].backgroundColor = .clear
        
        let upLine = UIView(frame: CGRect(x: -8, y: 0, width: selectedPickerView.layer.frame.width, height: 1.5))
        let underLine = UIView(frame: CGRect(x: -8, y: 42, width: selectedPickerView.layer.frame.width, height: 1.5))
        
        upLine.backgroundColor = .black
        underLine.backgroundColor = .black
        
        selectedPickerView.subviews[1].addSubview(upLine)
        selectedPickerView.subviews[1].addSubview(underLine)
    }
    
    
    func popupAlert(firstBtnTitle: String? = "취소", secondBtnTitle: String? = "확인", content: String, myView: UIView){
        cancleButton.setTitle(firstBtnTitle, for: .normal)
        okButton.setTitle(secondBtnTitle, for: .normal)
        contentLabel.text = content
        
        calendarView.isHidden = true
        popupView.isHidden = false
        testUIView = myView
    }
    
    func calendarAlert(currentYear: String, currentMonth: String, myView: UIView){
        cancleButton.setTitle("취소", for: .normal)
        okButton.setTitle("확인", for: .normal)
        
        calendarView.isHidden = false
        popupView.isHidden = true
        
        testUIView = myView
    }
}


extension AlertView: UIPickerViewDataSource, UIPickerViewDelegate {
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
        if pickerView == yearPickerView {
            return yearArr.count
        } else if pickerView == monthPickerView {
            return monthArr.count
        }
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Goyang", size: 14)
            pickerLabel?.textAlignment = .center
        }
        
        if pickerView == yearPickerView {
            pickerLabel?.text = "\(yearArr[row])년"
        } else if pickerView == monthPickerView {
            pickerLabel?.text = "\(monthArr[row])월"
        }
        
        return pickerLabel!
    }
    
    
    //  피커뷰에서 선택시 호출
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == yearPickerView {
            print(yearArr[row])
        } else if pickerView == monthPickerView {
            print(monthArr[row])
        }
    }
    
}
