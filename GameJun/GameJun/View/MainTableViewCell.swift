//
//  MainTableViewCell.swift
//  GameJun
//
//  Created by JEON JUNHA on 2021/05/11.
//

import UIKit
import SnapKit

final class MainTableViewCell: UITableViewCell {
    
    let gameTitleLabel = UILabel()
    let gameImageView = UIImageView()
    
    // MARK: - Properties
    static let identifier = "CustomTableViewCell"
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI
extension MainTableViewCell {
    final private func setUI() {
        setBasics()
        setLayout()
    }
    final private func setBasics() {
        gameTitleLabel.font = gameTitleLabel.font.withSize(24)
//        gameTitleLabel.textColor = .white
        
//        gameImageView.backgroundColor = .white
    }
    final private func setLayout() {
        [gameTitleLabel, gameImageView].forEach {
            contentView.addSubview($0)
        }
        gameImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(60)
            $0.width.height.equalTo(52)
        }
        gameTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(gameImageView.snp.trailing).offset(60)
        }
    }
}
