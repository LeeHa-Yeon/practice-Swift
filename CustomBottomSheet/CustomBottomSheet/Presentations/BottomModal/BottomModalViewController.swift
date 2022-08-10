//
//  BottomModalViewController.swift
//  CustomBottomSheet
//
//  Created by hayeon.lee on 2022/08/10.
//

import UIKit
import SnapKit
import Then

class BottomModalViewController: UIViewController {
    
    // MARK: - Properties
    let bottomHeight: CGFloat = 359 // 바텀 시트 높이
//    private var bottomSheetViewTopConstraint: NSLayoutConstraint! // bottomSheet와 View 상단에서 떨어진 거리
    
    // MARK: - Components
    private lazy var bottomSheetView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 24
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
    }
    

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    // MARK: - Functions
    // UI 세팅 작업
    func setUI(){
        view.backgroundColor = .black.withAlphaComponent(0.7)
    }
    
    // 레이아웃 세팅 작업
    func setLayout(){
        view.addSubview(bottomSheetView)
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        
//        let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
        bottomSheetView.snp.makeConstraints{ $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(160) }
        bottomSheetView.snp.makeConstraints{
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
        }
        bottomSheetView.snp.makeConstraints{
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
        }
        bottomSheetView.snp.makeConstraints{
            $0.bottom.equalTo(view.snp.bottom)
        }
        
        
    }

}
