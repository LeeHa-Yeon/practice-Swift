//
//  ViewController.swift
//  CustomPopUp
//
//  Created by hayeon.lee on 2022/08/09.
//

import UIKit
import SnapKit
import Then

//protocol CustomPopUpDelegate {
//    func rightAction()
//}

enum ButtonLocation {
    case left
    case right
}

class FirstPopUpViewController: UIViewController {
    // MARK: - Properties
//    public var delegate: CustomPopUpDelegate?
    private var titleText: String?
    private var contentText: String?
    
    // MARK: - Components
    @IBOutlet weak var presnetView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    // MARK: - Initialize
    convenience init(test: String? = nil) {
        self.init()
        // present시 fullScreen 설정
        modalPresentationStyle = .overFullScreen
        
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setUI(titleText: "gg", contentText: "ss", leftButtonType: nil, rightButtonType: nil)
//        animationEffect()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        // curveEaseOut: 시작은 천천히, 끝날 땐 빠르게
//        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut) {
//            [weak self] in
//            self?.containerView.transform = .identity
//            self?.containerView.isHidden = false
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        // curveEaseIn: 시작은 빠르게, 끝날 땐 천천히
//        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn) {
//            [weak self] in
//            self?.containerView.transform = .identity
//            self?.containerView.isHidden = true
//        }
    }
    
    func setUI(titleText: String? = nil, contentText: String? = nil, leftButtonType: UIButton? = nil, rightButtonType: UIButton? = nil){
        guard let titleTextek = titleText else {
            titleLabel.isHidden = true
            return
        }
        guard let contentTextek = contentText else {
            contentLabel.isHidden = true
            return
        }
        guard let leftButtonType = leftButtonType else {
            leftButton.isHidden = true
            return
        }
        guard let rightButtonType = rightButtonType else {

            rightButton.isHidden = true
            return
        }
        
        self.titleLabel.text = titleTextek
        self.contentLabel.text = contentTextek
        self.leftButton = leftButtonType
        self.rightButton = rightButtonType
    }
    
    
    func setupView(){
        view.backgroundColor = .black.withAlphaComponent(0.3)
    }
    
    func animationEffect(){
        presnetView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    }
    
    
    func buttonAction(location: ButtonLocation ,completion: (()-> Void)? = nil ){
        switch location {
        case .left:
            leftButton.addAction(for: .touchUpInside) { _ in
                completion?()
            }
        case .right:
            rightButton.addAction(for: .touchUpInside) { _ in
                completion?()
            }
        }
        
    }
    
}
