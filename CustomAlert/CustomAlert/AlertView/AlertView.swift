//
//  AlertView.swift
//  CustomAlert
//
//  Created by 이하연 on 2022/03/22.
//

import Foundation
import UIKit

class AlertView: UIView {
    
    @IBOutlet var customView: UIView!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // autoresizingMask로 모든 화면에 맞춰줌
    private func commonInit() {
        Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)
        customView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        customView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(customView)
    }
    
}
