import UIKit

class AlertView: UIView {
    
    public var delegate: CustomAlertProtocol?
    
    
    // MARK: - Properties
    var currentView: UIView!
    
    // MARK: - UIComponents
    
    @IBOutlet var parentMainView: UIView!
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.delegate?.cancleButtonTapped(currentView)
    }
    
    @IBAction func okButtonTapped(_ sender: UIButton) {
        self.delegate?.okButtonTapped(currentView)
    }
    
    
    // MARK: - LifeCycle
    
    override func layoutSubviews() {
        setLayer()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    // MARK: - Functions

    
    // 모든 화면에 맞춰주는 작업
    private func initialize() {
        Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)
        parentMainView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentMainView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(parentMainView)
    }
    
    // 버튼 테두리 생성
    func setLayer(){
        
        popupView.layer.cornerRadius = 20
        
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor(named: "soulMain")?.cgColor
        cancelButton.layer.cornerRadius = 27
        
        okButton.layer.borderWidth = 1
        okButton.layer.borderColor = UIColor(named: "soulMain")?.cgColor
        okButton.layer.cornerRadius = 27
    }
    
    
    // 팝업 표시
    func popupAlert(iconStyle: alertIconStyle, title: String ,message: String, firstBtnTitle: String? = "아니요", secondBtnTitle: String? = "예",myView: UIView){
        
        switch iconStyle {
        case .exclamationIcon :
            iconImageView.image = UIImage(named: "exclamationIcon")
            break
        case .questionIcon :
            iconImageView.image = UIImage(named: "questionIcon")
            break
        }
        
        titleLabel.text = title
        messageLabel.text = message
        
        cancelButton.setTitle(firstBtnTitle, for: .normal)
        okButton.setTitle(secondBtnTitle, for: .normal)
        
        currentView = myView
    }
    
}

protocol CustomAlertProtocol {
    func cancleButtonTapped(_ popupView: UIView)
    func okButtonTapped(_ popupView: UIView)
}

enum alertIconStyle: String {
    case exclamationIcon
    case questionIcon
}
