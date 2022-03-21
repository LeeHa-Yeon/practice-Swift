//
//  ViewController.swift
//  CustomCalendar
//
//  Created by 이하연 on 2022/03/20.
//

import UIKit

class CalendarViewController: UIViewController {

    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}


extension CalendarViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }

    
    
}

class CalendarCell: UICollectionViewCell {
    @IBOutlet weak var dayOfMonth: UILabel!
    @IBOutlet weak var coffeeImage: UIImageView!
}
