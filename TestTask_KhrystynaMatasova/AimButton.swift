//
//  AimButton.swift
//  TestTask_KhrystynaMatasova
//
//  Created by Roma Test on 08.08.2021.
//

import UIKit

struct AimButtonViewModel {
    let image = UIImage(named: "balloon")
}

final class AimButton: UIButton {
    private let buttonImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(buttonImage)
        clipsToBounds = true
        layer.cornerRadius = frame.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: AimButtonViewModel) {
        buttonImage.image = viewModel.image
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buttonImage.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
    }
    
    
    
    
}
