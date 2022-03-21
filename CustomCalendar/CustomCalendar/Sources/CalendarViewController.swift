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
    
//    var selectedDate = Date()
//    var totalSquares = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
//    func setMonthView()
//    {
//        totalSquares.removeAll()
//        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
//        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
//        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
//
//        var count: Int = 1
//
//        while(count <= 42)
//        {
//            if(count <= startingSpaces || count - startingSpaces > daysInMonth)
//            {
//                totalSquares.append("")
//            }
//            else
//            {
//                totalSquares.append(String(count - startingSpaces))
//            }
//            count += 1
//        }
//
//        yearLabel.text =
//            CalendarHelper().yearString(date: selectedDate)
//        monthLabel.text = CalendarHelper().monthString(date: selectedDate).uppercased()
//        collectionView.reloadData()
//    }
    
}


extension CalendarViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 10) / 8
        let height = (collectionView.frame.size.height - 2) /  12
        return CGSize(width: width, height: height)
    }
}

class CalendarCell: UICollectionViewCell {
    @IBOutlet weak var dayOfMonth: UILabel!
    @IBOutlet weak var coffeeImage: UIImageView!
}
