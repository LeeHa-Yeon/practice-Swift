//
//  ViewController.swift
//  CollecionViewTest
//
//  Created by 이하연 on 2022/02/22.
//

import UIKit

protocol ViewControllerDelegate {
    func sendData(data: UITextField!, idx: Int)
}

extension ViewController: ViewControllerDelegate {
    func sendData(data: UITextField!, idx: Int) {
        workOutName[idx] = data.text ?? ""
    }
}

class ViewController: UIViewController {
    var workOutName: [String] = []
    
    // MARK: - Components
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        print("\(workOutName)")
    }
    
    @IBAction func addBtnTapped(_ sender: Any) {
        workOutName.append("")
        collectionView.reloadData()
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        setData()
    }
    
    
    // MARK: - Functions
    func setCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setData(){
        workOutName = ["",""]
        collectionView.reloadData()
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workOutName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "testCell", for: indexPath) as? TestCell else {
            return UICollectionViewCell()
        }
        cell.currentIdx = indexPath.row
        cell.delegate = self
        return cell
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin:CGFloat = 10
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth =  (screenWidth-margin) / CGFloat(2)
        let cellHeight = CGFloat(50)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}

class TestCell: UICollectionViewCell {
    
    var delegate : ViewControllerDelegate?
    var currentIdx: Int = 0
    
    @IBOutlet weak var inputTextField: UITextField!
    
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        inputTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    /* 텍스트필드의 값이 변경될 때 */
    @objc func textFieldDidChange(_ textField: UITextField) {
        delegate?.sendData(data: textField, idx: currentIdx)
    }
    
}
