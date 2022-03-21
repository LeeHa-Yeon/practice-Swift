//
//  ViewController.swift
//  CustomAlert
//
//  Created by 이하연 on 2022/03/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBAction func testBtn(_ sender: Any) {
        let customView = AlertView()
        view.addSubview(customView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

