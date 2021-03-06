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
    
    var timer:Timer?
    var timeLeft = 0
    let timeTextField = UITextField()
    let button = playButton()
    let systemSoundID: SystemSoundID = 1005
    var bombImageView = UIImageView()
    let dismissButton = DismissButton()
    let secLabel = UILabel()
    let timerLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
        timer = nil
    }
    
    // 스크린 터치시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension TimerViewController {
    @objc
    func onTimerFires() {
        timeLeft -= 1
        transform()
        if timeLeft <= 0 {
            bombImageView.stopAnimating()
            bombImageView.image = UIImage(named: "boom")
            AudioServicesPlaySystemSound (systemSoundID)
            timer?.invalidate()
            timer = nil
            [button, timeTextField, secLabel, timerLabel].forEach {
                $0.isHidden = false
            }
        }
    }
    
    @objc
    func tapButton(_ sender: UIButton) {
        view.endEditing(true)
        if timeTextField.text == "" {
            return
        } else {
            bombImageView.image = UIImage(named: "bomb")
            timeLeft = Int(timeTextField.text ?? "0") ?? 0
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
            [button, timeTextField, secLabel, timerLabel].forEach {
                $0.isHidden = true
            }
            self.view.endEditing(true)
        }
    }
    
    @objc
    func tapDismissButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        timer?.invalidate()
        timer = nil
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

// MARK: - Delegate
extension TimerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.tapButton(self.button)
        return true
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
        
        timeTextField.keyboardType = .numberPad
        timeTextField.textAlignment = .center
        timeTextField.backgroundColor = .white
        timeTextField.layer.borderWidth = 2.0
        timeTextField.layer.borderColor = UIColor.gray.cgColor
        timeTextField.delegate = self
        timeTextField.textColor = .black

        bombImageView.image = UIImage(named: "bomb")
        
        dismissButton.addTarget(self, action: #selector(tapDismissButton(_:)), for: .touchUpInside)
        secLabel.text = "초"
        secLabel.textColor = .white
        secLabel.font = secLabel.font.withSize(20)
        timerLabel.text = "타이머 설정 :"
        timerLabel.textColor = .white
        timerLabel.font = secLabel.font.withSize(20)
    }
    
    final private func setLayout() {
        [button, timeTextField, bombImageView, dismissButton, secLabel, timerLabel].forEach {
            view.addSubview($0)
        }
        bombImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.width.height.equalTo(300)
        }
        timeTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(36)
            $0.centerY.equalToSuperview().offset(20)
            $0.width.height.equalTo(40)
        }
        secLabel.snp.makeConstraints {
            $0.centerY.equalTo(timeTextField)
            $0.leading.equalTo(timeTextField.snp.trailing).offset(8)
        }
        timerLabel.snp.makeConstraints {
            $0.centerY.equalTo(timeTextField)
            $0.trailing.equalTo(timeTextField.snp.leading).offset(-8)
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
