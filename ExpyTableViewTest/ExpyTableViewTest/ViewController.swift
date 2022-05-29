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
    var rowList: [String] = ["Suboption","Suboption","Suboption"]
    
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
        print("\(sectionList[indexPath.section]) - \(rowList[indexPath.row])")
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
        return false
    }
    
    //Edit Mode에서 Row별 모드 지정
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row == 0 {
            return .insert
        } else {
            return .delete
        }
    }
     
    //Edit Mode의 +, - 버튼
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            print("delete")
            self.rowList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else {
            print("insert")
            self.rowList.insert(self.rowList[indexPath.row], at: indexPath.row + 1)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    //Edit Mode의 Row 이동
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("\(self.rowList) from: \(sourceIndexPath.row) -> to: \(destinationIndexPath.row)")
        let targetItem: String = self.rowList[sourceIndexPath.row]
        self.rowList.remove(at: sourceIndexPath.row)
        self.rowList.insert(targetItem, at: destinationIndexPath.row)
    }

    
}

class SectionCell: UITableViewCell {
    @IBOutlet weak var sectionLabel: UILabel!
    
}

class RowCell: UITableViewCell {
    @IBOutlet weak var rowLabel: UILabel!
    
}
