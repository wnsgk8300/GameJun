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
    let startButton = UIButton(type: .system)
    var initialQuizText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
}
// MARK: - UI
extension HunminGameViewController {
    final private func setUI() {
        setBasics()
        setLayout()
    }
    final private func setBasics() {
        startButton.setTitle("플레이!", for: .normal)
        startButton.addTarget(self, action: #selector(tapStartButton(_:)), for: .touchUpInside)
        startButton.titleLabel?.font = .systemFont(ofSize: 60)
        
        initialLabel.textAlignment = .center
        initialLabel.font = initialLabel.font.withSize(80)
    }
    final private func setLayout() {
        [initialLabel, startButton].forEach {
            view.addSubview($0)
        }
        initialLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-80)
        }
        startButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(40)
        }
    }
}
