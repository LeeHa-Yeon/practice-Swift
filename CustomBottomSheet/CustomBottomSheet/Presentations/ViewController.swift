//
//  ViewController.swift
//  CustomBottomSheet
//
//  Created by hayeon.lee on 2022/08/10.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func bottomSheetBtnTapped(_ sender: Any) {
        let bottomSheetVC = BottomModalViewController()
        bottomSheetVC.modalPresentationStyle = .overFullScreen
        self.present(bottomSheetVC, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
    }


}

