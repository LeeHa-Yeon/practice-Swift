//
//  BasicViewController.swift
//  CustomPopUp
//
//  Created by hayeon.lee on 2022/08/09.
//

import UIKit


class BasicViewController: UIViewController {
    
    @IBAction func testBtnTapped(_ sender: Any) {
        showPopUp(title: "방 나가기", content: "채팅 내용은 다시 복구되지 않습니다.\n정말 나가시겠어요?", leftButtonTitle: "취소오", leftButtonStyle: nil, rightButtonTitle: "나가기", rightButtonStyle: nil, leftActionCompletion: {
            print("테스트중~~")
        }, rightActionCompletion: nil)
        
//        showPopUp(title: "비밀번호 확인", content: "비밀번호 오류횟수가 5회 이상\n초과 되었습니다.\n\n비밀번호를 재설정 하세요.", leftButtonTitle: "취소", leftButtonStyle: nil, rightButtonTitle: "재설정 하기", rightButtonStyle: nil) {
//            print("없엉")
//        } rightActionCompletion: {
//            print("흠")
//        }
//        showPopUp(title: "비밀번호 확인", content: nil, leftButtonTitle: "취소", leftButtonStyle: nil, rightButtonTitle: "재설정 하기", rightButtonStyle: nil) {
//            print("없엉")
//        } rightActionCompletion: {
//            print("흠")
//        }

        
//        showPopUp(title: nil, content: "Imperdiet mattis congue\n pellentesque fames ultrices turpis \nsenectus. Nisi, sit nunc amet amet,\n rhoncus. Turpis pulvinar ridiculus \naenean vitae, ornare turpis arcu \nsuscipit. At felis ultricies volutpat id \nlorem gravida fermentum massa. \nCursus mi augue mauris est, amet \nvolutpat, justo. Pretium netus mi elit \nnulla diam feugiat et mauris. ", leftButtonTitle: "취소", leftButtonStyle: nil, rightButtonTitle: "확인", rightButtonStyle: nil) {
//            print("왼쪽버튼")
//        } rightActionCompletion: {
//            print("오른쪽버튼")
//        }

        
        showPopUp(title: "방 나가기", content: "채팅 내용은 다시 복구되지 않습니다.\n정말 나가시겠어요?", leftButtonTitle: "취소오", rightButtonTitle: "나가기", leftActionCompletion: nil) {
            print("테스트중~~")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
