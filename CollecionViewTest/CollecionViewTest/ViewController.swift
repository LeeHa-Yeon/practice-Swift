//
//  ViewController.swift
//  CollecionViewTest
//
//  Created by 이하연 on 2022/02/22.
//

import UIKit


protocol ViewControllerDelegate {
    func sendData(data: UITextField!)
}

extension ViewController: ViewControllerDelegate {
    func sendData(data: UITextField!) {
        currentData = data.text ?? ""
    }
}


class ViewController: UIViewController {
    
    var currentData: String = ""
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        print("\(currentData)")
        
    }
    
    
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "testCell", for: indexPath) as? TestCell else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth =  200
        let cellHeight = 200
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}


extension ViewController: UICollectionViewDelegate {
    
    
}

class TestCell: UICollectionViewCell {
    
    var delegate : ViewControllerDelegate?
    
    @IBOutlet weak var inputTextField: UITextField!
    
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        inputTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    
    
    
    /* 텍스트필드의 값이 변경될 때 */
    @objc func textFieldDidChange(_ textField: UITextField) {
        delegate?.sendData(data: textField)
    }
    
}
