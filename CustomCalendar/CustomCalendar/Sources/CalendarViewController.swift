//
//  ViewController.swift
//  CustomCalendar
//
//  Created by 이하연 on 2022/03/20.
//

import UIKit

protocol testDelegate {
    func moveToVC()
}

class CalendarViewController: UIViewController {
    
    var selectedDate = Date()
    var totalSquares = [String]()
    
    // MARK: - UIComponents
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setMonthView()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // 해당 달의 일수 설정
    func setMonthView(){
        // totalSquares 초기화
        totalSquares.removeAll()
        
        // 칸의 위치
        var count: Int = 0
        
        // 해당 날의 일수
        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        // 전날 마지막 날짜
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        //  해당 월의 1일의 위치 -> date에는 첫번째날짜가 있어야됨 ( 0 ~ 6 )
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
        
        // 칸의 갯수 (42개 : 0~41)
        // 월마다 일수가 유동적으로 변하니까 cell의 갯수를 6*7로 만듬
        while count < 42 {
            let dayLocation = count - startingSpaces
            
            if(dayLocation < 0 || dayLocation >= daysInMonth){
                totalSquares.append("")
            } else {
                totalSquares.append(String(dayLocation+1))
            }
            count += 1
        }
        
        
        yearLabel.text = CalendarHelper().yearString(date: selectedDate)
        monthLabel.text = CalendarHelper().monthString(date: selectedDate).uppercased()
        collectionView.reloadData()
    }
    
}


extension CalendarViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as? CalendarCell else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        cell.dayOfMonth.text = totalSquares[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(collectionView.frame.size.width)
        let width = (collectionView.frame.size.width - 10) / 8
        let height = (collectionView.frame.size.height - 2) /  12
        print("width -> \(width)")
        return CGSize(width: width, height: height)
    }
}

class CalendarCell: UICollectionViewCell {
    
    var delegate: testDelegate?
    @IBOutlet weak var testBtn: UIButton!
    @IBOutlet weak var dayOfMonth: UILabel!
    @IBOutlet weak var coffeeImage: UIImageView!
    
    @IBAction func moveToVC(_ sender: Any) {
        delegate?.moveToVC()
    }

}

extension CalendarViewController: testDelegate {
    func moveToVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let MainVC = storyboard.instantiateViewController(identifier: "MainSB")
        MainVC.modalPresentationStyle = .fullScreen
        present(MainVC, animated: true, completion: nil)
    }
}
