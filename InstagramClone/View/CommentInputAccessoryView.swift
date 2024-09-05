//
//  CommentInputAccessoryView.swift
//  InstagramClone
//
//  Created by Nihad on 02.09.24.
//

import UIKit
import SnapKit

protocol CommentInputAccessoryViewDelegate: AnyObject {
    func inputView(_ inputView: CommentInputAccessoryView, wantsToUploadComment comment: String)
}

class CommentInputAccessoryView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: CommentInputAccessoryViewDelegate?
    
    private let commentTextView: InputTextView = {
       let tv = InputTextView()
        tv.placeHolderText = "Enter comment.."
        tv.font = UIFont.systemFont(ofSize: 15)
        tv.isScrollEnabled = false
        tv.placeHolderShouldCenter = true
        return tv
    }()
    
    private let postButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Post", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(handlePostTapped), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        autoresizingMask = .flexibleHeight
        
        let divider = UIView()
        divider.backgroundColor = .lightGray
        
        addSubview(postButton)
        addSubview(commentTextView)
        addSubview(divider)
        
        postButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview().inset(8)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        commentTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalTo(postButton.snp.left).inset(8)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(8)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    // MARK: - Actions
    
    @objc func handlePostTapped() {
        delegate?.inputView(self, wantsToUploadComment: commentTextView.text)
    }

    // MARK: - Helpers
    
    func clearCommentTextView() {
        commentTextView.text = nil
        commentTextView.placeHolderLabel.isHidden = false
    }
    
}
