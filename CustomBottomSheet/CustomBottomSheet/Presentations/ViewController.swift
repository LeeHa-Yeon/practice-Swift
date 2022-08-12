//
//  ViewController.swift
//  CustomBottomSheet
//
//  Created by hayeon.lee on 2022/08/10.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func bottomSheetBtnTapped(_ sender: Any) {
        showBottomModal()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
    }


}


extension UIViewController {
    
    // 이용약관 동의
    
    // 애칭 설정 바텀시트 구조
    
    // 거주 국가 선택 구조
    
    func showBottomModal(){
        let bottomSheetVC = BottomModalViewController()
        
        
        let titleLabel = UILabel()
        titleLabel.text = "타이틀"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.numberOfLines = 0
        
        let contentLabel = UILabel()
        contentLabel.text = "내용내뇽ㅇ내애내애낸앵"
        contentLabel.textAlignment = .center
        contentLabel.textColor = .black
        contentLabel.font = .systemFont(ofSize: 16, weight: .bold)
        contentLabel.numberOfLines = 0
        
        let titleLabel2 = UILabel()
        titleLabel2.text = "타이틀"
        titleLabel2.textAlignment = .center
        titleLabel2.textColor = .black
        titleLabel2.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel2.numberOfLines = 0
        
        let contentLabel2 = UILabel()
        contentLabel2.text = "내용내뇽ㅇ내애내애낸앵"
        contentLabel2.textAlignment = .center
        contentLabel2.textColor = .black
        contentLabel2.font = .systemFont(ofSize: 16, weight: .bold)
        contentLabel2.numberOfLines = 0
        
        let testStackView = UIStackView()
        testStackView.axis = .vertical
        testStackView.spacing = 0
        testStackView.distribution = .equalSpacing
        testStackView.addArrangedSubview(titleLabel)
        testStackView.addArrangedSubview(contentLabel)
        testStackView.addArrangedSubview(titleLabel2)
        testStackView.addArrangedSubview(contentLabel2)
        
        
        bottomSheetVC.addComponents(targetStackView: testStackView)
        
        bottomSheetVC.modalPresentationStyle = .overFullScreen
        self.present(bottomSheetVC, animated: false)
    }
}
