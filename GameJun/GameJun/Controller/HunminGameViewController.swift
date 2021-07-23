//
//  HunminGameViewController.swift
//  GameJun
//
//  Created by JEON JUNHA on 2021/05/08.
//

import UIKit
import SnapKit

class HunminGameViewController: UIViewController {
    
    let initial = ["ㄱ", "ㄴ", "ㄷ", "ㄹ", "ㅁ", "ㅂ", "ㅅ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
    let initialLabel = UILabel()
    let startButton = playButton()
    var initialQuizText = ""
    let dismissButton = DismissButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUI()
    }
    
    func gameStart() {
        initialLabel.text = ""
        initialLabel.text?.append(initial.randomElement() ?? "")
        initialLabel.text?.append(initial.randomElement() ?? "")
    }
}

// MARK: - Selector
extension HunminGameViewController {
    @objc
    func tapStartButton(_ sender: UIButton) {
        gameStart()
    }
    @objc
    func tapDismissButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UI
extension HunminGameViewController {
    final private func setUI() {
        setBasics()
        setLayout()
    }
    
    final private func setBasics() {
        startButton.addTarget(self, action: #selector(tapStartButton(_:)), for: .touchUpInside)
        startButton.imageName = "3"
        
        initialLabel.text = "  "
        initialLabel.textAlignment = .center
        initialLabel.font = initialLabel.font.withSize(120)
        initialLabel.textColor = .white
        initialLabel.layer.cornerRadius = 10
        initialLabel.layer.borderColor = UIColor.white.cgColor
        initialLabel.layer.borderWidth = 2
        
        dismissButton.addTarget(self, action: #selector(tapDismissButton(_:)), for: .touchUpInside)
    }
    
    final private func setLayout() {
        [initialLabel, startButton, dismissButton].forEach {
            view.addSubview($0)
        }
        initialLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            $0.width.equalTo(300)
        }
        startButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(80)
        }
        dismissButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}
