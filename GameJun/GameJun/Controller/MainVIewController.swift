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
    let LiarButton = UIButton(type: .system)
    let InitialButton = UIButton(type: .system)
    let HunminButton = UIButton(type: .system)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
    }
}
extension MainVIewController {
    @objc
    func tapMenuButton(_ sender: UIButton) {
        switch sender.titleLabel?.text {
        case "라이어 게임":
            let nextVC = LiarGameViewController()
            present(nextVC, animated: true, completion: nil)
        case "초성 퀴즈":
            let nextVC = InitialQuizViewController()
            present(nextVC, animated: true, completion: nil)
        case "훈민정음 게임":
            let nextVC = HunminGameViewController()
            present(nextVC, animated: true, completion: nil)
        default:
            fatalError()
        }
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
        
        LiarButton.setTitle("라이어 게임", for: .normal)
        LiarButton.addTarget(self, action: #selector(tapMenuButton(_:)), for: .touchUpInside)
        
        InitialButton.setTitle("초성 퀴즈", for: .normal)
        InitialButton.addTarget(self, action: #selector(tapMenuButton(_:)), for: .touchUpInside)
        
        HunminButton.setTitle("훈민정음 게임", for: .normal)
        HunminButton.addTarget(self, action: #selector(tapMenuButton(_:)), for: .touchUpInside)
        
        [LiarButton, InitialButton, HunminButton].forEach {
            $0.titleLabel?.font = .systemFont(ofSize: 24)
        }
    }
    final private func setLayout() {
        [titleLabel, LiarButton, InitialButton, HunminButton].forEach {
            view.addSubview($0)
        }
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        LiarButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
        }
        InitialButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(LiarButton.snp.bottom).offset(20)
        }
        HunminButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(InitialButton.snp.bottom).offset(20)
        }
    }
}
