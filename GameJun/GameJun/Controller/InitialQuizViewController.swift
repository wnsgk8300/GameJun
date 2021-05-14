//
//  InitialQuizViewController.swift
//  GameJun
//
//  Created by JEON JUNHA on 2021/05/03.
//

import UIKit
import SnapKit

class InitialQuizViewController: UIViewController {
    
    
    
    let createButton = UIButton(type: .system)
    let startButton = UIButton()
    let customQuizButton = UIButton()
    
    let gameView = UIView()
    let movieTitleLabel = UILabel()
    let answerTextField = UITextField()
    let answerButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system)
    
    var movieTitle = String()
    var movieTitles = [""]
    let dismissButton = DismissButton()
    
//    var _out2:NSString = "";
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        view.backgroundColor = .black
        answerTextField.isHidden = true
        nextButton.isHidden = true
    }
    

    
    
}
// MARK: - 초성 변환
extension InitialQuizViewController {

    func initial(movieTitle: NSString) -> String {
        var initial:String = "";
        for i in 0..<movieTitle.length{
            let oneChar:UniChar = movieTitle.character(at:i)
            if( oneChar >= 0xAC00 && oneChar <= 0xD7A3 ){
                var firstCodeValue = ((oneChar - 0xAC00)/28)/21
                firstCodeValue += 0x1100;
                initial = initial.appending(String(format:"%C", firstCodeValue))
//                _out2 = _out2.appendingFormat("%C", firstCodeValue)
            }else{
                initial = initial.appending(String(format:"%C", oneChar))
//                _out2 = _out2.appendingFormat("%C", oneChar)
            }
        }
//        print(initial)
//        print(_out2)
        return initial
    }
}
extension InitialQuizViewController {
    @objc
    func tapMainButton(_ sender: UIButton) {
        gameView.isHidden = false
        switch sender {
        case startButton:
            nextButton.isHidden = false
            movieTitles = InitialQuizManager.shared.movieTitle
            movieTitle = movieTitles.randomElement() ?? ""
            movieTitleLabel.text = initial(movieTitle: movieTitle as NSString)
            nextButton.isHidden = true
        case createButton:
            answerTextField.isHidden = false
        default:
            fatalError()
        }
    }
    @objc
    func tapGameButton(_ sender: UIButton) {
        switch sender {
        case answerButton:
            movieTitleLabel.text = movieTitle as String
            answerButton.isHidden = true
            nextButton.isHidden = false
        case nextButton:
            nextButton.isHidden = true
            movieTitles.removeAll(where: { $0 == movieTitle as String })
            if movieTitles.count == 0 {
                nextButton.isHidden = false
                movieTitleLabel.text = "게임 끝!"
                answerButton.isHidden = true
                nextButton.setTitle("확인", for: .normal)
            } else {
                answerButton.isHidden = false
                movieTitle = movieTitles.randomElement() ?? ""
                movieTitleLabel.text = initial(movieTitle: movieTitle as NSString)
            }
            if nextButton.titleLabel?.text == "확인" {
//                gameView.isHidden = true
                nextButton.setTitle("다음 문제", for: .normal)
                self.dismiss(animated: true, completion: nil)
            }
        default:
            fatalError()
        }
    }
    @objc
    func tapDismissButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UI
extension InitialQuizViewController {
    final private func setUI() {
        setBasics()
        setLayout()
    }
    final private func setBasics() {
        [startButton, createButton].forEach {
            $0.addTarget(self, action: #selector(tapMainButton(_:)), for: .touchUpInside)
        }
        startButton.setTitle("플레이!", for: .normal)
        startButton.titleLabel?.font = .systemFont(ofSize: 60)
        startButton.setImage(UIImage(named: "2"), for: .normal)
        

        createButton.setTitle("문제 내기", for: .normal)
        
        gameView.isHidden = true
        gameView.backgroundColor = .black
        
        [answerButton, nextButton].forEach {
            $0.titleLabel?.font = .systemFont(ofSize: 24)
            $0.addTarget(self, action: #selector(tapGameButton(_:)), for: .touchUpInside)
        }
        answerButton.setTitle("정답 확인하기", for: .normal)
        nextButton.setTitle("다음 문제", for: .normal)
        
        movieTitleLabel.font = .systemFont(ofSize: 60)
        movieTitleLabel.textAlignment = .center
        movieTitleLabel.numberOfLines = 2
        movieTitleLabel.textColor = .white
        
        dismissButton.addTarget(self, action: #selector(tapDismissButton(_:)), for: .touchUpInside)

    }
    
    final private func setLayout() {
        [startButton, createButton, gameView, dismissButton].forEach {
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
        [movieTitleLabel, answerButton, nextButton, answerTextField].forEach {
            gameView.addSubview($0)
        }
        movieTitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(140)
        }
        answerButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(20)
        }
        nextButton.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.top.equalTo(answerButton.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(20)
        }
        answerTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
            $0.leading.top.equalToSuperview()
//            $0.top.equalTo(nextButton.snp.bottom)
//            $0.width.equalTo(200)
        }
        dismissButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}
