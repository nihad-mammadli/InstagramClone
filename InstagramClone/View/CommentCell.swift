//
//  CommentCell.swift
//  InstagramClone
//
//  Created by Nihad on 01.09.24.
//

import UIKit
import SnapKit
import SDWebImage

class CommentCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var viewModel: CommentViewModel? {
        didSet { configure() }
    }
    
    private let profileImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private let commentLabel = UILabel()
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        addSubview(commentLabel)
        
        commentLabel.numberOfLines = 0
        
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalToSuperview().offset(8)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        profileImageView.layer.cornerRadius = 40 / 2
        
        commentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(profileImageView.snp.right).offset(8)
            make.right.equalToSuperview().inset(8)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let viewModel = viewModel else { return }
        
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        commentLabel.attributedText = viewModel.commentLabelText()
    }
    
}
