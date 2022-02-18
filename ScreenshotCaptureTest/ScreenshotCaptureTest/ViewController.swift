//
//  ViewController.swift
//  ScreenshotCaptureTest
//
//  Created by 이하연 on 2022/02/18.
//

import UIKit
import Photos

class ViewController: UIViewController {
    
    var screenShotImgView: UIImage?
    
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
        
        screenShotImgView = screenshot
        shareAction()
        
        UIImageWriteToSavedPhotosAlbum(screenshot, self, #selector(imageWasSaved), nil)
    }
    
    // 공유하는 함수
    func shareAction(){
        var objectsToShare = [UIImage]()
        if let image = screenShotImgView {
            objectsToShare.append(image)
        }
        
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        // 공유하기 기능 중 제외할 기능이 있을 때 사용
        //        activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
        self.present(activityVC, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    @objc func imageWasSaved(_ image: UIImage, error: Error?, context: UnsafeMutableRawPointer) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        print("Image was saved in the photo gallery")
//        UIApplication.shared.open(URL(string:"photos-redirect://")!)
    }
    
    
    
}

