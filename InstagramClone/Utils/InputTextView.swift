//
//  InputTextView.swift
//  InstagramClone
//
//  Created by Nihad on 31.08.24.
//

import UIKit
import SnapKit

class InputTextView: UITextView {
    
    // MARK: - Properties
    
    var placeHolderText: String? {
        didSet { placeHolderLabel.text = placeHolderText }
    }
    
    let placeHolderLabel: UILabel = {
       let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    
    var placeHolderShouldCenter = true {
        didSet {
            if placeHolderShouldCenter {
                
                placeHolderLabel.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(6)
                    make.right.equalToSuperview().offset(8)
                    make.centerY.equalTo(self)
                }
                
            } else {
                
                placeHolderLabel.snp.makeConstraints { make in
                    make.top.equalToSuperview().offset(6)
                    make.left.equalToSuperview().offset(8)
                    }
                
            }
        }
    }
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        addSubview(placeHolderLabel)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleDidTextChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func handleDidTextChange() {
        placeHolderLabel.isHidden = !text.isEmpty
    }
}
