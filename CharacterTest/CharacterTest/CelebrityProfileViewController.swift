//
//  CelebrityProfileViewController.swift
//  CharacterTest
//
//  Created by 이하연 on 2022/04/12.
//

import UIKit
import Then
import SnapKit

class CelebrityProfileViewController: UIViewController {
    
    lazy var collectionView = UICollectionView().then {
        $0.delegate = self
        $0.dataSource = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension CelebrityProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "oneLineCell", for: indexPath) as? OneLineCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let margin:CGFloat = 25
            let cellRatio: CGFloat = 5/3
            let screenWidth = UIScreen.main.bounds.width
            let cellWidth =  (screenWidth-margin) / CGFloat(2)
        let cellHeight = 20.0
            return CGSize(width: cellWidth, height: cellHeight)
        }
 
    
}

class OneLineCell: UICollectionViewCell {
    
}

class PhraseCell: UICollectionViewCell {
    
}
