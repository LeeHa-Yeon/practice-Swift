//
//  ViewController.swift
//  CustomPopUp
//
//  Created by hayeon.lee on 2022/08/09.
//

import UIKit
import SnapKit
import Then

enum ButtonType {
    case key
    case mono
    case error
}

class FirstPopUpViewController: UIViewController {
    
    // MARK: - Properties
    private var titleText: String?
    private var contentText: String?
    private var attributedContentText: NSAttributedString?
    private var leftButtonType: ButtonType?
    private var rightButtonType: ButtonType?
    
    private lazy var containerViewStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0.0
        $0.alignment = .center
    }
    
    private lazy var mainView = UIView().then {
        $0.layer.cornerRadius = 12
        $0.backgroundColor = .white
    }
    
    private lazy var entireStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 24
        $0.distribution = .fillProportionally
        $0.addArrangedSubview(labelStackView)
        $0.addArrangedSubview(buttonStackView)
    }
    
    private lazy var buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 0
        $0.distribution = .fillEqually
    }
    
    private lazy var labelStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
        $0.distribution = .fill
        
    }
    
    private lazy var titleLabel: UILabel? = {
        let label = UILabel()
        label.text = titleText
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.textColor = UIColor(hex: 0x26282E)
        return label
    }()
    
    private lazy var contentLabel: UILabel? = {
        let label = UILabel()
        label.text = contentText
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.textColor = UIColor(hex: 0x484951)
        return label
    }()
    
    public func addActionBtn(title: String? = nil, titleColor: UIColor = UIColor(hex: 0x575A63), backgroundColor: UIColor = .white, completion:(() -> Void)? = nil){
        let button = UIButton()
        // normal로 하니 디자인 시안과 다르게 나와서 bold로 설정했는데 추후 논의해보기 
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
//        button.layer.cornerRadius = 4.0
//        button.layer.masksToBounds = true
        
        
        button.addAction(for: .touchUpInside) { _ in
            completion?()
        }
        
        buttonStackView.addArrangedSubview(button)
    }

    // MARK: - Initialize
    convenience init(titleText: String? = nil, contentText: String? = nil, leftButtonType: ButtonType? = nil, rightButtonType: ButtonType? = nil){
        self.init()
        
        self.titleText = titleText
        self.contentText = contentText
        self.leftButtonType = leftButtonType
        self.rightButtonType = rightButtonType
        
        // present시 fullScreen 설정
        modalPresentationStyle = .overFullScreen
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubViews()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // curveEaseOut: 시작은 천천히, 끝날 땐 빠르게
//        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut) {
//            [weak self] in
//            self?.mainView.transform = .identity
//            self?.mainView.isHidden = false
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // curveEaseIn: 시작은 빠르게, 끝날 땐 천천히
//        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn) {
//            [weak self] in
//            self?.mainView.transform = .identity
//            self?.mainView.isHidden = true
//        }
    }
    
    private func setupView(){
        view.backgroundColor = .black.withAlphaComponent(0.7)
        mainView.addSubview(entireStackView)
        containerViewStackView.addArrangedSubview(mainView)
        view.addSubview(containerViewStackView)
    }
    
    private func addSubViews(){
        if let _ = titleLabel?.text {
            if let titleLabel = titleLabel {
                labelStackView.addArrangedSubview(titleLabel)
            }
        }
        
        if let _ = contentLabel?.text {
            if let contentLabel = contentLabel {
                labelStackView.addArrangedSubview(contentLabel)
            }
        }
        
//        if let lastView = containerViewStackView.subviews.last {
//            containerViewStackView.setCustomSpacing(24.0, after: lastView)
//        }
    }
    
    private func setLayout() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        containerViewStackView.translatesAutoresizingMaskIntoConstraints = false
        entireStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        containerViewStackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.trailing.leading.equalToSuperview().inset(48)
        }
        
        mainView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }

        entireStackView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(32)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
        labelStackView.snp.makeConstraints{
            $0.height.greaterThanOrEqualTo(57)
        }
        
        buttonStackView.snp.makeConstraints{
            $0.height.equalTo(48)
        }
        
    }

}
