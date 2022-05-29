//
//  ViewController.swift
//  TableViewMoveTest
//
//  Created by 이하연 on 2022/05/30.
//

import UIKit

enum EditType {
  case None, All, Delete, Sort
}

class ViewController: UIViewController {
    
    var list: [String] = ["row1","row2","row3","row4"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        // Do any additional setup after loading the view.
    }
    
    func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.setEditing(true, animated: true)
    
        
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "rowCell", for: indexPath) as? RowCell else {
            return UITableViewCell()
        }
        cell.numberLabel.text = "\(indexPath.row) - \(list[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {

        return .none
        
    }
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = list[sourceIndexPath.row]
        list.remove(at: sourceIndexPath.row)
        list.insert(itemToMove, at: destinationIndexPath.row)
    }
}

class RowCell: UITableViewCell {
    @IBOutlet weak var numberLabel: UILabel!
    
}
