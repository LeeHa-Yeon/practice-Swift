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
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        // Do any additional setup after loading the view.
    }
    
    func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.setEditing(true, animated: true) // 항상 편집모드
        leftConstraint.constant = -38 // 삭제단추 제거한 부분 (이거 한줄)
        
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
    
    // 4. 편집모드일 때 기본적으로 삭제하는 아이콘 뜨는데 그거를 none으로 바꾼거
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    // 2. reorder하는 부분 ( 이동하는 코드 이게 끝 )
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = list[sourceIndexPath.row]
        list.remove(at: sourceIndexPath.row)
        list.insert(itemToMove, at: destinationIndexPath.row)
    }
    
    //  3. reorder control image custom ( 이게 끝 )
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            
            var myReorderImage: UIImage?
            
            for subView in cell.subviews {
                if (subView.classForCoder.description() == "UITableViewCellReorderControl") {
                    
                    // reorder control frame 을 변경해서 세부적인 위치를 맞춰준다. - 오른쪽 간격 맞추기 위해서
                    let reorderControl = subView
                    let frame = reorderControl.frame
                    reorderControl.frame = CGRect(x: self.view.frame.width - 56, y: frame.minY, width: frame.width, height: frame.height)
                    
                    for subViewB in reorderControl.subviews {
                        if (subViewB.isKind(of: UIImageView.classForCoder())) {
                            // reorder control default image 제거
                            subViewB.removeFromSuperview()
                            
                            let imageView = UIImageView()
                            if (myReorderImage == nil) {
                                let myImage = imageView.image
                                myReorderImage = myImage?.withRenderingMode(.alwaysTemplate)
                            }
                            
                            // reorder control image 변경
                            var frame = imageView.frame
                            frame.origin.x = 0
                            frame.origin.y = 10
                            frame.size = CGSize(width: 20, height: 20)
                            myReorderImage = UIImage(named: "gg") // set your image
                            imageView.frame = frame
                            imageView.image = myReorderImage
                            reorderControl.addSubview(imageView) // add imageView to reorder control
                            
                            break
                        }
                    }
                    break
                }
            }
        }
}

class RowCell: UITableViewCell {
    @IBOutlet weak var numberLabel: UILabel!
    
}
