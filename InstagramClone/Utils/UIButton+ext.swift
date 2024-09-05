//
//  UIButton+ext.swift
//  InstagramClone
//
//  Created by Nihad on 28.08.24.
//

import UIKit

extension UIButton {
    func attributedTitle(firstPart: String, secondPart: String, fontSize: CGFloat) {
        
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.87), .font: UIFont.systemFont(ofSize: fontSize)]
        let attributedTitle = NSMutableAttributedString(string: "\(firstPart) ", attributes: atts)
        
        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.87), .font: UIFont.boldSystemFont(ofSize: fontSize)]
        attributedTitle.append(NSAttributedString(string: secondPart, attributes: boldAtts))
        
        setAttributedTitle(attributedTitle, for: .normal)
        
    }
}
