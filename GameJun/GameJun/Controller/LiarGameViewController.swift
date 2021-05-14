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
    let changeButton = UIButton()
    let topicViewLayout = UICollectionViewFlowLayout()
    lazy var selectTopicView = UICollectionView(frame: .zero, collectionViewLayout: topicViewLayout)
    let topics = ["영화", "가수", "동물", "노래", "음식", "위인", "운동", "도시", "어플"]
    
    let settingView = UIView()
    let viewInSettingView = UIView()
    let participantsLabel = UILabel()
    let participantsNumberLabel = UILabel()
    var participants = 3
    let modeLabel = UILabel()
    let modeChangeView = UIView()
    let gameModes = ["노말 모드", "스파이 모드", "바보 모드"]
    var modeChangeIndex = 0
    let modeLeftButton = UIButton(type: .system)
    let modeRightButton = UIButton(type: .system)
    let startButton = playButton()
    let countUpButton = UIButton(type: .system)
    let countDownButton = UIButton(type: .system)
    
    let gameStartView = UIView()
    let readyView = UIView()
    let liarLable = UILabel()
    let curtainButton = UIButton()
    let okButton = UIButton()
    var liarNum = 0
    var liarText = ""
    var unSelected = [""]
    
    var countParticipants = 0
    let dismissButton = DismissButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
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
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 2
        
        return cell
    }
}
// MARK: - Selector
extension LiarGameViewController {
    @objc
    func tapChangeButton(_ sender: UIButton) {
        startButton.isHidden = true
        if selectTopicView.isHidden {
            selectTopicView.isHidden = false
        } else {
            selectTopicView.isHidden = true
        }
    }
    @objc
    func tapTopicButton(_ sender: UIButton) {
        startButton.isHidden = false
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
        selectTopicView.isHidden = true
        startButton.isEnabled = false
    }
    @objc
    func tapCountUpButton(_ sender: UIButton) {
        participants += 1
        participantsNumberLabel.text = "\(participants)명"
    }
    @objc
    func tapCountDownButton(_ sender: UIButton) {
        if participants == 3 {
            return
        } else {
            participants -= 1
            participantsNumberLabel.text = "\(participants)명"
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
        if modeChangeIndex != 2 {
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
            startButton.isEnabled = true
        }
    }
    @objc
    func tapDismissButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension LiarGameViewController {
    func setUI() {
        setBasic()
        setDetail()
        setTopicViewLayout()
    }
    func setDetail() {
//        topicView.backgroundColor = .red
        settingView.backgroundColor = .black
        selectTopicView.backgroundColor = .yellow
        gameStartView.backgroundColor = .black
        
        settingView.layer.cornerRadius = 10
        settingView.layer.borderColor = UIColor.red.cgColor
        settingView.layer.borderWidth = 2
        
        topicLabel.textColor = .white
        topicLabel.font = topicLabel.font.withSize(40)
        
        setTopicLabel.textColor = .red
        setTopicLabel.font = UIFont.boldSystemFont(ofSize: 52)
        
        changeButton.titleLabel?.textColor = .white
        changeButton.titleLabel?.font = .systemFont(ofSize: 32)
        
        topicLabel.text = "주제 :"
        participantsLabel.text = " 참가인원 :"
        participantsNumberLabel.text = "3명"
        [participantsLabel, participantsNumberLabel].forEach {
            $0.textColor = .white
            $0.font = .systemFont(ofSize: 36)
        }
        
        changeButton.setTitle("변경", for: .normal)
        changeButton.addTarget(self, action: #selector(tapChangeButton(_:)), for: .touchUpInside)
        changeButton.clipsToBounds = true
        changeButton.layer.cornerRadius = 10
        changeButton.layer.borderColor = UIColor.white.cgColor
        changeButton.layer.borderWidth = 2
        
        selectTopicView.dataSource = self
        selectTopicView.backgroundColor = .black
        selectTopicView.register(SelectTopicCollectionViewCell.self, forCellWithReuseIdentifier: SelectTopicCollectionViewCell.identifier)
        
        startButton.imageName = "1"
        startButton.addTarget(self, action: #selector(tapStartButton(_:)), for: .touchUpInside)
        
        countUpButton.setImage(UIImage(systemName: "arrowtriangle.up.fill"), for: .normal)
        countDownButton.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
//        countUpButton.setImage(UIImage(named: "redUp"), for: .normal)
//        countDownButton.setImage(UIImage(named: "redDown"), for: .normal)
        countUpButton.addTarget(self, action: #selector(tapCountUpButton(_:)), for: .touchUpInside)
        countDownButton.addTarget(self, action: #selector(tapCountDownButton(_:)), for: .touchUpInside)
        
        modeLabel.text = "노말 모드"
        modeLabel.textAlignment = .center
        modeLabel.font = .systemFont(ofSize: 32)
        modeLabel.textColor = .white
        modeLeftButton.setImage(UIImage(systemName: "arrowtriangle.left.fill"), for: .normal)
        modeRightButton.setImage(UIImage(systemName: "arrowtriangle.right.fill"), for: .normal)
//        modeLeftButton.setImage(UIImage(named: "redLeft"), for: .normal)
//        modeRightButton.setImage(UIImage(named: "redRight"), for: .normal)
        modeLeftButton.addTarget(self, action: #selector(tapModeLeftButton), for: .touchUpInside)
        modeRightButton.addTarget(self, action: #selector(tapModeRightButton), for: .touchUpInside)
        
        [countUpButton, countDownButton, modeLeftButton, modeRightButton].forEach {
            $0.tintColor = .red
        }
        
        curtainButton.backgroundColor = .red
        curtainButton.setTitle("준비 되셨나요?", for: .normal)
        curtainButton.addTarget(self, action: #selector(tapCurtainButton(_:)), for: .touchUpInside)
        curtainButton.layer.cornerRadius = 10
        curtainButton.layer.borderWidth = 2
        curtainButton.titleLabel?.font = .systemFont(ofSize: 40)
        
        liarLable.textAlignment = .center
        liarLable.numberOfLines = 2
        liarLable.font = .boldSystemFont(ofSize: 32)
        liarLable.textColor = .white
        
        okButton.setTitle("OK!", for: .normal)
        okButton.addTarget(self, action: #selector(tapOkButton(_:)), for: .touchUpInside)
        okButton.setTitleColor(.red, for: .normal)
        okButton.titleLabel?.font = .systemFont(ofSize: 24)
        
        dismissButton.addTarget(self, action: #selector(tapDismissButton(_:)), for: .touchUpInside)

    }
    func setBasic() {
        [setTopicLabel, topicLabel, changeButton, settingView, selectTopicView, gameStartView, startButton, dismissButton].forEach {
            view.addSubview($0)
        }
//        topicView.snp.makeConstraints {
//            $0.top.equalToSuperview().offset(80)
//            $0.centerX.equalToSuperview()
//            $0.width.equalTo(240)
//            $0.height.equalTo(100)
//        }
        selectTopicView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(setTopicLabel.snp.bottom).offset(20)
            $0.width.height.equalTo(300)
        }
        
//        [topicLabel, setTopicLabel, changeButton].forEach {
//            topicView.addSubview($0)
//        }
        setTopicLabel.snp.makeConstraints {
//            $0.top.bottom.equalToSuperview().inset(24)
//            $0.leading.equalTo(topicLabel.snp.trailing).offset(40)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(80)
            $0.width.equalTo(100)
        }
        topicLabel.snp.makeConstraints {
//            $0.top.leading.bottom.equalToSuperview().inset(24)
            $0.centerY.equalTo(setTopicLabel)
            $0.trailing.equalTo(setTopicLabel.snp.leading).offset(-20)
        }
        
        changeButton.snp.makeConstraints {
//            $0.top.trailing.bottom.equalToSuperview().inset(24)
            $0.centerY.equalTo(setTopicLabel)
            $0.leading.equalTo(setTopicLabel.snp.trailing).offset(40)
            $0.width.equalTo(80)
        }
        
//        settingView.snp.makeConstraints {
////            $0.top.equalTo(topicView.snp.bottom).offset(40)
////            $0.centerX.equalToSuperview()
////            $0.width.height.equalTo(topicView.snp.width)
//            $0.top.equalTo(setTopicLabel.snp.bottom).offset(40)
//            $0.centerX.equalToSuperview()
//            $0.width.height.equalTo(200)
//        }

        
        settingView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(setTopicLabel.snp.bottom).offset(20)
            $0.width.equalTo(selectTopicView)
            $0.bottom.equalTo(startButton.snp.top).offset(-20)
        }
        
        startButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(100)
        }
        dismissButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        [participantsLabel, participantsNumberLabel, modeLabel, countUpButton, countDownButton, modeChangeView].forEach {
            settingView.addSubview($0)
        }
        participantsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(52)
            $0.leading.equalToSuperview().offset(20)
        }
        participantsNumberLabel.snp.makeConstraints {
            $0.centerY.equalTo(participantsLabel)
            $0.trailing.equalTo(countUpButton.snp.leading).offset(-16)
        }
        countUpButton.snp.makeConstraints {
            $0.centerY.equalTo(participantsLabel).offset(-16)
            $0.leading.equalTo(participantsLabel.snp.trailing).offset(88)
        }
        countDownButton.snp.makeConstraints {
            $0.centerY.equalTo(participantsLabel).offset(16)
            $0.centerX.equalTo(countUpButton)
        }
        modeChangeView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-52)
            $0.height.equalTo(24)
        }
        gameStartView.snp.makeConstraints {
            $0.edges.equalTo(settingView).inset(12)
        }
        [liarLable, okButton, curtainButton].forEach {
            gameStartView.addSubview($0)
        }
        curtainButton.snp.makeConstraints {
            $0.top.equalTo(settingView.snp.top).offset(20)
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(260)
            $0.height.equalTo(180)
            
        }
        liarLable.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-20)
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        okButton.snp.makeConstraints {
            $0.top.equalTo(liarLable).offset(60)
            $0.width.equalTo(40)
            $0.centerX.equalToSuperview()
        }
        
        [modeLeftButton, modeLabel, modeRightButton].forEach {
            modeChangeView.addSubview($0)
        }
        modeLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(160)
        }
        modeLeftButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(modeLabel.snp.leading).offset(-20)
        }
        modeRightButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(modeLabel.snp.trailing).offset(20)
        }
    }
    
    func setTopicViewLayout() {
        topicViewLayout.scrollDirection = .vertical
        topicViewLayout.itemSize = CGSize(width: 80, height: 80)
        //        topicViewLayout.minimumInteritemSpacing = 4
        //        topicViewLayout.minimumLineSpacing = 8
        topicViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
