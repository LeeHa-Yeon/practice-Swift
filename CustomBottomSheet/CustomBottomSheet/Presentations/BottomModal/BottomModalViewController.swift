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
    
    private var sheetLeadingMargin: CGFloat = 24
    private var sheetTralingMargin: CGFloat = 24
    private var sheetTopMargin: CGFloat = 40
    private var sheetBottomMargin: CGFloat = 34
    
    // MARK: - Properties
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
        $0.addSubview(containerStackView)
    }
    
    private lazy var containerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 0
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
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(blurredView)
        view.addSubview(bottomSheetView)
        
        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom
        
        blurredView.snp.makeConstraints{
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        bottomSheetView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            bottomSheetViewTopConstraint = $0.top.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.top).offset(safeAreaHeight + bottomPadding).constraint
        }
        
        containerStackView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(sheetLeadingMargin)
            $0.top.equalToSuperview().inset(sheetTopMargin)
            $0.bottom.equalToSuperview().inset(sheetBottomMargin)
        }
    }
    
    public func addComponents(targetStackView: UIStackView){
        containerStackView = targetStackView
    }
    
    
    // 바텀 시트 표출 애니메이션
    private func showBottomSheet() {
        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom
        let bottomHeight: CGFloat = containerStackView.frame.height
        
        bottomSheetViewTopConstraint?.update(offset: (safeAreaHeight + bottomPadding) - bottomHeight )
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    // 바텀 시트 사라지는 애니메이션
    private func hideBottomSheetAndGoBack() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        
        bottomSheetViewTopConstraint?.update(offset: safeAreaHeight + bottomPadding )
    
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
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
