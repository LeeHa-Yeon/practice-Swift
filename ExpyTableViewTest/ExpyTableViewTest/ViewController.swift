//
//  ViewController.swift
//  ExpyTableViewTest
//
//  Created by 이하연 on 2022/05/25.
//

import UIKit
import ExpyTableView

class ViewController: UIViewController {
    let sectionList: Array<String> = ["Option1","Option2"]
    let rowList: [String] = ["Suboption","Suboption","Suboption"]
    
    @IBOutlet weak var tableView: ExpyTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        // Do any additional setup after loading the view.
    }
    
    func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
    }


}


extension ViewController: ExpyTableViewDelegate, ExpyTableViewDataSource {
    
    // 열리고 닫힐 때 확인
   func tableView(_ tableView: ExpyTableView, expyState state: ExpyState, changeForSection section: Int) {
       print("\(section)섹션")
   }
    
    // 섹션 갯수
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionList.count
    }
    
    // 선택시 어떤 셀이 선택되었는지 이벤트를 처리
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(sectionList[indexPath.row]) - \(rowList[indexPath.row])")
    }
    
    // cell 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // row 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowList.count
    }
    
    // 섹션 내용
    func tableView(_ tableView: ExpyTableView, expandableCellForSection section: Int) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell") as? SectionCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .systemGray
        cell.sectionLabel.text = sectionList[section]
        cell.selectionStyle = .none //선택했을 때 회색되는거 없애기
        return cell

    }
    
    // row 내용
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "rowCell") as? RowCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .systemPink
        cell.rowLabel.text = rowList[indexPath.row]
        cell.selectionStyle = .none //선택했을 때 회색되는거 없애기
        return cell
    }
    
    // true: 열고 닫는거 가능, false: 다 펼쳐진 상태로 고정
    func tableView(_ tableView: ExpyTableView, canExpandSection section: Int) -> Bool {
        return true
    }
    
}

class SectionCell: UITableViewCell {
    @IBOutlet weak var sectionLabel: UILabel!
    
}

class RowCell: UITableViewCell {
    @IBOutlet weak var rowLabel: UILabel!
    
}
