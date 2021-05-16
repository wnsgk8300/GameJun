//
//  TimerViewController.swift
//  GameJun
//
//  Created by JEON JUNHA on 2021/05/09.
//

import UIKit
import SnapKit
import AVFoundation

class TimerViewController: UIViewController {
    //    let timeLabel = UILabel()
    var timer:Timer?
    var timeLeft = 0
    let timeTextField = UITextField()
    let button = playButton()
    let systemSoundID: SystemSoundID = 1005
    var bombImageView = UIImageView()
    let dismissButton = DismissButton()
    let secLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUI()
    }
}

extension TimerViewController {
    @objc
    func onTimerFires()
    {
        timeLeft -= 1
        //        timeLabel.text = "\(timeLeft) seconds left"
        transform()
        if timeLeft <= 0 {
            bombImageView.stopAnimating()
            bombImageView.image = UIImage(named: "pixelBoom")
            AudioServicesPlaySystemSound (systemSoundID)
            timer?.invalidate()
            timer = nil
            button.isHidden = false
            timeTextField.isHidden = false
            secLabel.isHidden = false
        }
    }
    @objc
    func tapButton(_ sender: UIButton) {
        bombImageView.image = UIImage(named: "pixelBomb")
        timeLeft = Int(timeTextField.text ?? "0") ?? 0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        //        timeLabel.text = "\(timeLeft) seconds left"
        button.isHidden = true
        timeTextField.isHidden = true
        secLabel.isHidden = true
    }
    @objc
    func tapDismissButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension TimerViewController {
    
    func transform() {
        UIView.animate(withDuration: 1.0, animations: {
            self.bombImageView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }){
            (_) in
            UIView.animate(withDuration: 1.0) {
                self.bombImageView.transform = CGAffineTransform.identity
            }
        }
    }
    
    
}
// MARK: - UI
extension TimerViewController {
    final private func setUI() {
        setBasics()
        setLayout()
    }
    final private func setBasics() {
        
        button.addTarget(self, action: #selector(tapButton(_:)), for: .touchUpInside)
        button.tintColor = .white
        button.imageName = "4"
        
        
        timeTextField.text = "15"
        timeTextField.keyboardType = .numberPad
        timeTextField.textAlignment = .center
        timeTextField.backgroundColor = .white
        timeTextField.layer.borderWidth = 2.0
        timeTextField.layer.borderColor = UIColor.gray.cgColor
        
        bombImageView.image = UIImage(named: "pixelBomb")
        
        dismissButton.addTarget(self, action: #selector(tapDismissButton(_:)), for: .touchUpInside)
        secLabel.text = "초"
        secLabel.textColor = .white
        secLabel.font = secLabel.font.withSize(20)
        
    }
    final private func setLayout() {
        [button, timeTextField, bombImageView, dismissButton, secLabel].forEach {
            view.addSubview($0)
        }
        bombImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.width.height.equalTo(240)
        }
        //        timeLabel.snp.makeConstraints {
        //            $0.centerX.centerY.equalToSuperview()
        //        }
        timeTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(20)
            $0.width.height.equalTo(40)
        }
        secLabel.snp.makeConstraints {
            $0.centerY.equalTo(timeTextField)
            $0.leading.equalTo(timeTextField.snp.trailing).offset(8)
        }
        button.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(80)
        }
        dismissButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}
