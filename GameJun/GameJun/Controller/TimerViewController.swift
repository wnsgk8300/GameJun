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
    let timeLabel = UILabel()
    var timer:Timer?
    var timeLeft = 0
    let timeTextField = UITextField()
    let button = UIButton(type: .system)
    let systemSoundID: SystemSoundID = 1005
    let bombImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        setUI()
    }
}

extension TimerViewController {
    @objc
    func onTimerFires()
    {
        timeLeft -= 1
        timeLabel.text = "\(timeLeft) seconds left"
        if timeLeft <= 0 {
            bombImageView.image = UIImage(named: "boom")
            AudioServicesPlaySystemSound (systemSoundID)
            timer?.invalidate()
            timer = nil
        }
    }
}
extension TimerViewController {
    @objc
    func tapButton(_ sender: UIButton) {
        timeLeft = Int(timeTextField.text ?? "0") ?? 0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        timeLabel.text = "\(timeLeft) seconds left"
    }
}
// MARK: - UI
extension TimerViewController {
    final private func setUI() {
        setBasics()
        setLayout()
    }
    final private func setBasics() {
        button.setTitle("시작하기", for: .normal)
        button.addTarget(self, action: #selector(tapButton(_:)), for: .touchUpInside)
               
        timeTextField.placeholder = "시간 입력"
        timeTextField.keyboardType = .numberPad
        timeTextField.textAlignment = .center
        
        bombImageView.image = UIImage(named: "bomb")
    }
    final private func setLayout() {
        [timeLabel, button, timeTextField, bombImageView].forEach {
            view.addSubview($0)
        }
        bombImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.width.height.equalTo(240)
        }
        timeLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        timeTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(timeLabel.snp.bottom).offset(20)
            $0.width.equalTo(80)
        }
        button.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(timeTextField.snp.bottom).offset(20)
        }
    }
}
