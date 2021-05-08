//
//  InitialQuizViewController.swift
//  GameJun
//
//  Created by JEON JUNHA on 2021/05/03.
//

import UIKit
import SnapKit

class InitialQuizViewController: UIViewController {
    var str:NSString = "한글 테스트4"
    var _out:String = "";
    
    let createButton = UIButton(type: .system)
    let startButton = UIButton(type: .system)
    
    let gameView = UIView()
    let movieTitleLabel = UILabel()
    let answerTextField = UITextField()
    let answerButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system)
    
//    var _out2:NSString = "";
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        view.backgroundColor = .white
    }
    

    
    
}
// MARK: - 초성 변환
extension InitialQuizViewController {

    func initial() {
        for i in 0..<str.length{
            let oneChar:UniChar = str.character(at:i)
            if( oneChar >= 0xAC00 && oneChar <= 0xD7A3 ){
                var firstCodeValue = ((oneChar - 0xAC00)/28)/21
                firstCodeValue += 0x1100;
                _out = _out.appending(String(format:"%C", firstCodeValue))
//                _out2 = _out2.appendingFormat("%C", firstCodeValue)
            }else{
                _out = _out.appending(String(format:"%C", oneChar))
//                _out2 = _out2.appendingFormat("%C", oneChar)
            }
        }
        print(_out)
//        print(_out2)
    }
}
extension InitialQuizViewController {
    @objc
    func tapMainButton(_ sender: UIButton) {
        gameView.isHidden = false
        switch sender {
        case startButton:
            print("start")
        case createButton:
            print("create")
        default:
            fatalError()
        }
    }
    @objc
    func tapGameButton(_ sender: UIButton) {
        switch sender {
        case answerButton:
            print("answer")
        case nextButton:
            print("next")
        default:
            fatalError()
        }
    }
}

// MARK: - UI
extension InitialQuizViewController {
    final private func setUI() {
        setBasics()
        setLayout()
    }
    final private func setBasics() {
        [startButton, createButton, answerButton, nextButton].forEach {
            $0.titleLabel?.font = .systemFont(ofSize: 24)
            $0.addTarget(self, action: #selector(tapMainButton(_:)), for: .touchUpInside)
        }
        startButton.setTitle("시작하기", for: .normal)
        createButton.setTitle("문제 내기", for: .normal)
        
        gameView.isHidden = true
        gameView.backgroundColor = .red
        
        [answerButton, nextButton].forEach {
            $0.titleLabel?.font = .systemFont(ofSize: 24)
            $0.addTarget(self, action: #selector(tapGameButton(_:)), for: .touchUpInside)
        }
        answerButton.setTitle("정답 확인하기", for: .normal)
        nextButton.setTitle("다음 문제", for: .normal)
    }
    
    final private func setLayout() {
        [startButton, createButton, gameView].forEach {
            view.addSubview($0)
        }
        startButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-60)
        }
        createButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(startButton.snp.bottom).offset(80)
        }
        gameView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        [movieTitleLabel, answerButton, nextButton].forEach {
            gameView.addSubview($0)
        }
        movieTitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(60)
        }
        answerButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(movieTitleLabel.snp.bottom).offset(60)
        }
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(answerButton.snp.bottom).offset(24)
        }
    }
}
