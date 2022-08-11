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
    var bottomHeight: CGFloat = 200 // 바텀 시트 높이
    private var bottomSheetViewTopConstraint: Constraint? = nil // bottomSheet와 View 상단에서 떨어진 거리
    
    // MARK: - Components
    private lazy var blurredView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.7)
    }
    
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
        setupGestureRecognizer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBottomSheet()
    }
    
    // MARK: - Functions
    // UI 세팅 작업
    private func setUI(){
        view.backgroundColor = .none
    }
    
    // 레이아웃 세팅 작업
    private func setLayout(){
        view.addSubview(blurredView)
        view.addSubview(bottomSheetView)
        
        
        let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
        
        blurredView.snp.makeConstraints{
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        bottomSheetView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            bottomSheetViewTopConstraint = $0.top.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.top).offset(topConstant).constraint
        }
    }
    
    // 바텀 시트 표출 애니메이션
    private func showBottomSheet() {
        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom
        
        bottomSheetViewTopConstraint?.update(offset: (safeAreaHeight + bottomPadding) - bottomHeight )
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
//            self.view.alpha = 0.5
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    // 바텀 시트 사라지는 애니메이션
    private func hideBottomSheetAndGoBack() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        
        bottomSheetViewTopConstraint?.update(offset: safeAreaHeight + bottomPadding )
    
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
//            self.view.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    // GestureRecognizer 세팅 작업
    private func setupGestureRecognizer() {
        // 흐린 부분 탭할 때, 바텀시트를 내리는 TapGesture
        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
        blurredView.addGestureRecognizer(dimmedTap)
        blurredView.isUserInteractionEnabled = true
        
        // 스와이프 했을 때, 바텀시트를 내리는 swipeGesture
//        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(panGesture))
//        swipeGesture.direction = .down
//        view.addGestureRecognizer(swipeGesture)
    }


    // UITapGestureRecognizer 연결 함수 부분
    @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheetAndGoBack()
    }
    
    // UISwipeGestureRecognizer 연결 함수 부분
    @objc func panGesture(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            switch recognizer.direction {
            case .down:
                hideBottomSheetAndGoBack()
            default:
                break
            }
        }
    }
}
