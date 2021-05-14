//
//  SelectTopicCollectionViewCell.swift
//  GameJun
//
//  Created by JEON JUNHA on 2021/04/28.
//
import UIKit

final class SelectTopicCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "SelectTopicCollectionViewCell"
    let topicButton = UIButton(type: .system)
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI
extension SelectTopicCollectionViewCell {
    final private func setUI() {
        setBasics()
        setLayout()
    }
    final private func setBasics() {
        topicButton.titleLabel?.font = .systemFont(ofSize: 24)
        topicButton.setTitleColor(.black, for: .normal)
    }
    final private func setLayout() {
        contentView.addSubview(topicButton)
        topicButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
