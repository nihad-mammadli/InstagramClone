//
//  UserCell.swift
//  InstagramClone
//
//  Created by Nihad on 30.08.24.
//

import UIKit

class UserCell: UITableViewCell {
    
    // MARK: - Properties
    
    var viewModel: UserCellViewModel?
    {
        didSet { configure() }
    }
    
    private var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.image = #imageLiteral(resourceName: "batman")
        return iv
    }()
    
    private var usernameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "batman"
        return label
    }()
    
    private var fullnameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Bruce Wayne"
        label.textColor = .lightGray
        return label
    }()
    
    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 48, height: 48))
            make.centerY.equalTo(self)
            make.left.equalToSuperview().offset(12)
        }
        profileImageView.layer.cornerRadius = 48 / 2
//        profileImageView.setDimensions(height: 48, width: 48)
//        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(profileImageView.snp.right).offset(8)
        }
//        stack.centerY(inView: self, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        
        profileImageView.sd_setImage(with: viewModel.profileImageURL)
        usernameLabel.text = viewModel.username
        fullnameLabel.text = viewModel.fullname
    }
    
}
