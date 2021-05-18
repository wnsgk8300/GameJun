//
//  DismissButton.swift
//  GameJun
//
//  Created by JEON JUNHA on 2021/05/13.
//

import UIKit

class DismissButton: UIButton {
    
    var borderWidth: CGFloat = 2.0
    var borderColor = UIColor.white.cgColor
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        self.clipsToBounds = true
        //        self.layer.cornerRadius = self.frame.size.width / 8
        //        self.layer.borderColor = borderColor
        //        self.layer.borderWidth = borderWidth
        self.setTitle("메인으로", for: .normal)
        self.setImage(UIImage(named: "0"), for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 30)
    }
}
class playButton: UIButton {
    
    @IBInspectable
    var imageName: String? {
        didSet {
            self.setImage(UIImage(named: imageName ?? "1" ), for: .normal)
        }
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        self.setTitle("플레이!", for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 60)
    }
}
