//
//  ViewController.swift
//  ScreenshotCaptureTest
//
//  Created by 이하연 on 2022/02/18.
//

import UIKit
import Photos

class ViewController: UIViewController {
    
    @IBOutlet weak var captureBtn: UIButton!
    @IBOutlet var backgroundShadowView: UIView!
    
    
    @IBAction func captureBtnTapped(_ sender: Any) {
        takeScreenshot(of: backgroundShadowView)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // 스크린 캡쳐하는 함수
    func takeScreenshot(of view: UIView) {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: view.bounds.width, height: view.bounds.height),
            false,
            2
        )

        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        UIImageWriteToSavedPhotosAlbum(screenshot, self, #selector(imageWasSaved), nil)
    }
    
    // MARK: - Actions
    @objc func imageWasSaved(_ image: UIImage, error: Error?, context: UnsafeMutableRawPointer) {
        if let error = error {
            print(error.localizedDescription)
            return
        }

        print("Image was saved in the photo gallery")
        UIApplication.shared.open(URL(string:"photos-redirect://")!)
    }
    
}

