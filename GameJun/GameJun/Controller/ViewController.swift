//
//  ViewController.swift
//  GameJun
//
//  Created by JEON JUNHA on 2021/04/28.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let topicView = UIView()
    let topicLabel = UILabel()
    let setTopicLabel = UILabel()
    let changeButton = UIButton()
    let topicViewLayout = UICollectionViewFlowLayout()
    lazy var selectTopicView = UICollectionView(frame: .zero, collectionViewLayout: topicViewLayout)
    let topics = ["영화", "가수", "동물", "노래", "음식", "위인", "운동", "도시", "물건"]
    
    let settingView = UIView()
    let groupLabel = UILabel()
    let numLabel = UILabel()
    let startButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        
    }
}
// MARK: - Datasource, Delegate
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = selectTopicView.dequeueReusableCell(withReuseIdentifier: SelectTopicCollectionViewCell.identifier, for: indexPath) as? SelectTopicCollectionViewCell else { fatalError() }
        cell.topicButton.setTitle(topics[indexPath.row] , for: .normal)
        cell.topicButton.addTarget(self, action: #selector(tapTopicButton(_:)), for: .touchUpInside)
        cell.backgroundColor = .white
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.systemIndigo.cgColor
        cell.layer.borderWidth = 2
        
        return cell
    }
}


extension ViewController {
    @objc
    func tapChangeButton(_ sender: UIButton) {
        selectTopicView.alpha = 1.0
    }
    @objc
    func tapTopicButton(_ sender: UIButton) {
        setTopicLabel.text = sender.titleLabel?.text
        selectTopicView.alpha = 0
    }
    
}
extension ViewController {
    func setUI() {
        setBasic()
        setDetail()
        setTopicViewLayout()
        
    }
    func setBasic() {
        [topicView, settingView, selectTopicView, startButton].forEach {
            view.addSubview($0)
        }
        topicView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(100)
        }
        settingView.snp.makeConstraints {
            $0.top.equalTo(topicView.snp.bottom).offset(80)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(400)
        }
        selectTopicView.snp.makeConstraints {
            $0.top.equalTo(settingView.snp.top).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(200)
        }
        
        [topicLabel, setTopicLabel, changeButton].forEach {
            topicView.addSubview($0)
        }
        topicLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(24)
        }
        setTopicLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(24)
            $0.leading.equalTo(topicLabel.snp.trailing).offset(40)
            $0.width.equalTo(80)
        }
        changeButton.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview().inset(24)
        }
        
        
    }
    func setDetail() {
        topicView.backgroundColor = .red
        settingView.backgroundColor = .green
        selectTopicView.backgroundColor = .yellow
        selectTopicView.alpha = 0
        topicLabel.text = "주제 :"
        
        changeButton.setTitle("변경", for: .normal)
        changeButton.addTarget(self, action: #selector(tapChangeButton(_:)), for: .touchUpInside)
        
        selectTopicView.dataSource = self
        selectTopicView.backgroundColor = .gray
        selectTopicView.register(SelectTopicCollectionViewCell.self, forCellWithReuseIdentifier: SelectTopicCollectionViewCell.identifier)
    }
    func setTopicViewLayout() {
        topicViewLayout.scrollDirection = .vertical
        topicViewLayout.itemSize = CGSize(width: 52, height: 52)
//        topicViewLayout.minimumInteritemSpacing = 4
//        topicViewLayout.minimumLineSpacing = 8
        topicViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
