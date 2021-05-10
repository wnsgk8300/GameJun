//
//  MainVIewController.swift
//  GameJun
//
//  Created by JEON JUNHA on 2021/05/03.
//

import UIKit
import SnapKit

class MainVIewController: UIViewController {
    let titleLabel = UILabel()
    let liarButton = UIButton(type: .system)
    let initialButton = UIButton(type: .system)
    let hunminButton = UIButton(type: .system)
    let timerButton = UIButton(type: .system)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
    }
}
extension MainVIewController {
    @objc
    func tapMenuButton(_ sender: UIButton) {
        var nextVC = UIViewController()
        switch sender.titleLabel?.text {
        case "라이어 게임":
            nextVC = LiarGameViewController()
        case "초성 퀴즈":
            nextVC = InitialQuizViewController()
        case "훈민정음 게임":
            nextVC = HunminGameViewController()
        case "폭탄 돌리기":
            nextVC = TimerViewController()
        default:
            fatalError()
        }
        present(nextVC, animated: true, completion: nil)
    }
}
// MARK: - UI
extension MainVIewController {
    final private func setUI() {
        setBasics()
        setLayout()
    }
    final private func setBasics() {
        titleLabel.textAlignment = .center
        titleLabel.font = titleLabel.font.withSize(30)
        titleLabel.text = "GameJun!"
        
        liarButton.setTitle("라이어 게임", for: .normal)
        
        initialButton.setTitle("초성 퀴즈", for: .normal)
        
        hunminButton.setTitle("훈민정음 게임", for: .normal)

        timerButton.setTitle("폭탄 돌리기", for: .normal)
        
        [liarButton, initialButton, hunminButton, timerButton].forEach {
            $0.titleLabel?.font = .systemFont(ofSize: 24)
            $0.addTarget(self, action: #selector(tapMenuButton(_:)), for: .touchUpInside)
        }
    }
    final private func setLayout() {
        [titleLabel, liarButton, initialButton, hunminButton, timerButton].forEach {
            view.addSubview($0)
        }
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(80)
        }
        liarButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
        }
        initialButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(liarButton.snp.bottom).offset(20)
        }
        hunminButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(initialButton.snp.bottom).offset(20)
        }
        timerButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(hunminButton.snp.bottom).offset(20)
        }
    }
}
