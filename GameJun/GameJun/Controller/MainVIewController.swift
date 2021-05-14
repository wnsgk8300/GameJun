//
//  MainVIewController.swift
//  GameJun
//
//  Created by JEON JUNHA on 2021/05/03.
//

import UIKit
import SnapKit

class MainVIewController: UIViewController {
    let menuTableView = UITableView()
    let titleImage = UIImageView()
    let bottomImageView = UIImageView()
    let games = ["라이어 게임", "영화 초성퀴즈", "훈민정음 게임", "폭탄 돌리기"]
//    let gameImages = ["LiarGame", "InitialQuiz", "HunminGame", "TimerGame"]
    let gameImages = ["1", "2", "3", "4"]
    let bottomImage = UIImage(named: "BottomImage3")
    let mainBackColor = UIColor.black
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = mainBackColor
        self.modalPresentationStyle = .overFullScreen

        menuTableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        menuTableView.dataSource = self
        menuTableView.delegate = self
        setUI()
    }
}
// MARK: - Delegate
extension MainVIewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = mainBackColor
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var nextVC = UIViewController()
        switch indexPath.row {
        case 0:
            nextVC = LiarGameViewController()
        case 1:
            nextVC = InitialQuizViewController()
        case 2:
            nextVC = HunminGameViewController()
        case 3:
            nextVC = TimerViewController()
        default:
            fatalError()
        }
        present(nextVC, animated: true, completion: nil)

    }
    
}
// MARK: - DataSource
extension MainVIewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let menuCell = menuTableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else { fatalError() }
        menuCell.gameImageView.image = UIImage(named: gameImages[indexPath.row])
        menuCell.gameTitleLabel.text = games[indexPath.row]
        menuCell.selectionStyle =  .none
        return menuCell
    }
    
    
}

// MARK: - UI
extension MainVIewController {
    final private func setUI() {
        setBasics()
        setLayout()
    }
    final private func setBasics() {
        titleImage.image = UIImage(named: "title")
        
        menuTableView.rowHeight = 100
        menuTableView.separatorStyle = .none
        menuTableView.alwaysBounceVertical = false
        menuTableView.backgroundColor = mainBackColor
        
        bottomImageView.image = bottomImage

    }
    final private func setLayout() {
        [menuTableView ,titleImage, bottomImageView].forEach {
            view.addSubview($0)
        }
        menuTableView.snp.makeConstraints {
            $0.top.equalTo(titleImage.snp.bottom).offset(28)
            $0.bottom.equalTo(bottomImageView.snp.top).offset(20)
            $0.leading.trailing.equalToSuperview()
        }
        titleImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            $0.width.equalTo(240)
            $0.height.equalTo(120)
        }
        bottomImageView.snp.makeConstraints {
//            $0.top.equalTo(menuTableView.snp.bottom).offset(20)
            $0.height.equalTo(140)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}
