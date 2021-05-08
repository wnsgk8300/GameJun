//
//  ViewController.swift
//  GameJun
//
//  Created by JEON JUNHA on 2021/04/28.
//

import UIKit
import SnapKit

class LiarGameViewController: UIViewController {
    let topicView = UIView()
    let topicLabel = UILabel()
    let setTopicLabel = UILabel()
    let changeButton = UIButton(type: .system)
    let topicViewLayout = UICollectionViewFlowLayout()
    lazy var selectTopicView = UICollectionView(frame: .zero, collectionViewLayout: topicViewLayout)
    let topics = ["영화", "가수", "동물", "노래", "음식", "위인", "운동", "도시", "어플"]
    
    let settingView = UIView()
    let viewInSettingView = UIView()
    let participantsLabel = UILabel()
    var participants = 3
    let modeLabel = UILabel()
    let modeChangeView = UIView()
    let gameModes = ["노말 모드", "스파이 모드", "바보 모드"]
    var modeChangeIndex = 0
    let modeLeftButton = UIButton(type: .system)
    let modeRightButton = UIButton(type: .system)
    let startButton = UIButton(type: .system)
    let countUpButton = UIButton(type: .system)
    let countDownButton = UIButton(type: .system)
    
    let gameStartView = UIView()
    let readyView = UIView()
    let liarLable = UILabel()
    let curtainButton = UIButton()
    let okButton = UIButton(type: .system)
    var liarNum = 0
    var liarText = ""
    var unSelected = [""]
    
    var countParticipants = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        selectTopicView.isHidden = true
        gameStartView.isHidden = true
        setTopicLabel.text = "영화"
    }
}
// MARK: - Datasource, Delegate
extension LiarGameViewController: UICollectionViewDataSource {
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
// MARK: - Selector
extension LiarGameViewController {
    @objc
    func tapChangeButton(_ sender: UIButton) {
        if selectTopicView.isHidden {
            selectTopicView.isHidden = false
        } else {
            selectTopicView.isHidden = true
        }
    }
    @objc
    func tapTopicButton(_ sender: UIButton) {
        setTopicLabel.text = sender.titleLabel?.text
        selectTopicView.isHidden = true
    }
    @objc
    func tapStartButton(_ sender: UIButton) {
        liarText = LiarGameManager.shared.topicText["\(setTopicLabel.text ?? "")"]?.randomElement() ?? ""
        gameStartView.isHidden = false
        changeButton.isHidden = true
        countParticipants = participants
        liarLable.text = liarText
        liarNum = Int.random(in: 1 ... participants)
        curtainButton.isHidden = false
        var selceted = LiarGameManager.shared.topicText["\(setTopicLabel.text ?? "")"] ?? [""]
        selceted.removeAll(where: { $0 == liarText })
        unSelected = selceted
    }
    @objc
    func tapCountUpButton(_ sender: UIButton) {
        participants += 1
        participantsLabel.text = "참가인원:     \(participants)명"
    }
    @objc
    func tapCountDownButton(_ sender: UIButton) {
        if participants == 3 {
            return
        } else {
            participants -= 1
            participantsLabel.text = "참가인원:     \(participants)명"
        }
    }
    @objc
    func tapModeLeftButton(_ sender: UIButton) {
        if modeChangeIndex != 0{
            modeChangeIndex -= 1
            modeLabel.text = gameModes[modeChangeIndex]
        } else {
            modeChangeIndex = 2
            modeLabel.text = gameModes[modeChangeIndex]
        }
    }
    @objc
    func tapModeRightButton(_ sender: UIButton) {
        if modeChangeIndex != 2{
            modeChangeIndex += 1
            modeLabel.text = gameModes[modeChangeIndex]
        } else {
            modeChangeIndex = 0
            modeLabel.text = gameModes[modeChangeIndex]
        }
    }
    @objc
    func tapCurtainButton(_ sender: UIButton) {
        if countParticipants == liarNum {
            switch modeLabel.text {
            case "노말 모드":
                liarLable.text = "라이어 당첨!"
            case "스파이 모드":
                liarLable.text = "당신은 스파이입니다!"
            case "바보 모드":
                liarLable.text = unSelected.randomElement()
            default:
                fatalError()
            }
            curtainButton.isHidden = true
        } else {
            curtainButton.isHidden = true
            liarLable.text = liarText
        }
    }
    @objc
    func tapOkButton(_ sender: UIButton) {
        if countParticipants != 1 {
            countParticipants -= 1
            curtainButton.isHidden = false
        } else {
            gameStartView.isHidden = true
            changeButton.isHidden = false
        }
    }
}
extension LiarGameViewController {
    func setUI() {
        setBasic()
        setDetail()
        setTopicViewLayout()
    }
    func setDetail() {
        topicView.backgroundColor = .red
        settingView.backgroundColor = .green
        selectTopicView.backgroundColor = .yellow
        viewInSettingView.backgroundColor = .white
        gameStartView.backgroundColor = .white
        
        topicLabel.text = "주제 :"
        participantsLabel.text = "참가인원:     3명"
        
        changeButton.setTitle("변경", for: .normal)
        changeButton.addTarget(self, action: #selector(tapChangeButton(_:)), for: .touchUpInside)
        
        selectTopicView.dataSource = self
        selectTopicView.backgroundColor = .gray
        selectTopicView.register(SelectTopicCollectionViewCell.self, forCellWithReuseIdentifier: SelectTopicCollectionViewCell.identifier)
        
        startButton.setTitle("게임 시작", for: .normal)
        startButton.addTarget(self, action: #selector(tapStartButton(_:)), for: .touchUpInside)
        
        countUpButton.setTitle("+", for: .normal)
        countDownButton.setTitle("-", for: .normal)
        countUpButton.addTarget(self, action: #selector(tapCountUpButton(_:)), for: .touchUpInside)
        countDownButton.addTarget(self, action: #selector(tapCountDownButton(_:)), for: .touchUpInside)
        
        modeLabel.text = "노말 모드"
        modeLabel.textAlignment = .center
        modeLeftButton.setImage(UIImage(systemName: "arrowtriangle.left.fill"), for: .normal)
        modeRightButton.setImage(UIImage(systemName: "arrowtriangle.right.fill"), for: .normal)
        modeLeftButton.addTarget(self, action: #selector(tapModeLeftButton), for: .touchUpInside)
        modeRightButton.addTarget(self, action: #selector(tapModeRightButton), for: .touchUpInside)
        
        curtainButton.backgroundColor = .red
        curtainButton.setTitle("준비 되셨나요?", for: .normal)
        curtainButton.addTarget(self, action: #selector(tapCurtainButton(_:)), for: .touchUpInside)
        
        liarLable.textAlignment = .center
        okButton.setTitle("OK!", for: .normal)
        okButton.addTarget(self, action: #selector(tapOkButton(_:)), for: .touchUpInside)
    }
    func setBasic() {
        [topicView, settingView, selectTopicView, gameStartView].forEach {
            view.addSubview($0)
        }
        topicView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(240)
            $0.height.equalTo(100)
        }
        selectTopicView.snp.makeConstraints {
            $0.centerX.centerY.equalTo(settingView)
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
        
        settingView.snp.makeConstraints {
            $0.top.equalTo(topicView.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(topicView.snp.width)
        }
        [viewInSettingView, startButton].forEach {
            settingView.addSubview($0)
        }
        viewInSettingView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(20)
            $0.width.equalTo(selectTopicView)
            $0.bottom.equalToSuperview().inset(80)
        }
        startButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(viewInSettingView.snp.bottom).offset(20)
            $0.width.equalTo(viewInSettingView.snp.width).inset(20)
        }
        [participantsLabel, modeLabel, countUpButton, countDownButton, modeChangeView].forEach {
            viewInSettingView.addSubview($0)
        }
        participantsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(12)
        }
        countUpButton.snp.makeConstraints {
            $0.centerY.equalTo(participantsLabel)
            $0.leading.equalTo(participantsLabel.snp.trailing).offset(12)
        }
        countDownButton.snp.makeConstraints {
            $0.centerY.equalTo(participantsLabel)
            $0.leading.equalTo(countUpButton.snp.trailing).offset(4)
            $0.trailing.equalToSuperview().inset(12)
        }
        modeChangeView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.top.equalTo(participantsLabel.snp.bottom).offset(20)
            $0.height.equalTo(24)
        }
        gameStartView.snp.makeConstraints {
            $0.edges.equalTo(settingView).inset(24)
        }
        [liarLable, okButton, curtainButton].forEach {
            gameStartView.addSubview($0)
        }
        curtainButton.snp.makeConstraints {
            $0.top.equalTo(settingView.snp.top).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(180)
        }
        liarLable.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        okButton.snp.makeConstraints {
            $0.top.equalTo(liarLable).offset(40)
            $0.width.equalTo(40)
            $0.centerX.equalToSuperview()
        }
        
        [modeLeftButton, modeLabel, modeRightButton].forEach {
            modeChangeView.addSubview($0)
        }
        modeLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(4)
            $0.width.equalTo(80)
        }
        modeLeftButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(modeLabel.snp.leading).offset(-8)
        }
        modeRightButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(modeLabel.snp.trailing).offset(8)
        }
    }
    
    func setTopicViewLayout() {
        topicViewLayout.scrollDirection = .vertical
        topicViewLayout.itemSize = CGSize(width: 52, height: 52)
        //        topicViewLayout.minimumInteritemSpacing = 4
        //        topicViewLayout.minimumLineSpacing = 8
        topicViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
