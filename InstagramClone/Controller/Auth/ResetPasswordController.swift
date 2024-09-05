//
//  ResetPasswordController.swift
//  InstagramClone
//
//  Created by Nihad on 03.09.24.
//

import UIKit

protocol ResetPasswordControllerDelegate: AnyObject {
    func controllerDidResetPasswordLink(_ controller: ResetPasswordController)
}

class ResetPasswordController: UIViewController {

    // MARK: - Properties
    
    private var viewModel = ResetPasswordViewModel()
    weak var delegate: ResetPasswordControllerDelegate?
    var email: String?
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    
    private let iconImage: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "icon1"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    private let resetPasswordButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Reset password", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        btn.layer.cornerRadius = 5
        btn.setHeight(50)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.isEnabled = false
        btn.addTarget(self, action: #selector(handleResetPassword), for: .touchUpInside)
        return btn
    }()
    
    private let backButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .white
        btn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        btn.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Actions
    
    @objc func handleResetPassword() {
        guard let email = emailTextField.text else { return }
        
        showLoader(true)
        AuthService.resetPassword(withEmail: email) { error in
            if let error = error {
                self.showAlert(withTitle: "Error", message: error.localizedDescription)
                self.showLoader(false)
            }
            
            self.delegate?.controllerDidResetPasswordLink(self)
            
        }
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        }
        updateForm()
    }
    
    @objc func handleDismiss() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers

    func configureUI() {
        configureGradientLayer()
        
        
        emailTextField.text = email
        viewModel.email = email
        updateForm()
        
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        
        view.addSubview(backButton)
        view.addSubview(iconImage)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        iconImage.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize(width: 120, height: 80))
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
        }
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, resetPasswordButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalTo(iconImage.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().inset(32)
        }
    }
}

// MARK: - FormViewModel

extension ResetPasswordController: FormViewModelProtocol {
    func updateForm() {
        resetPasswordButton.backgroundColor = viewModel.buttonBackgroundColor
        resetPasswordButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        resetPasswordButton.isEnabled = viewModel.formIsValid
    }
}
