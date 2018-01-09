//
//  ViewController.swift
//  LoginWithTouchID
//
//  Created by KHA on 1/8/18.
//  Copyright © 2018 Kha. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var touchIDButton: UIButton!
    
    let username = "username"
    let password = "12345678"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func login(username: String, password: String) -> Bool {
        if username == self.username && password == self.password {
            return true
        } else {
            return false
        }
    }

    func loginWithTouchID() {
        let context = LAContext()
        var error: NSError?
        context.localizedFallbackTitle = ""
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Use touch ID on device for login!"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [unowned self] success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.navigationController?.pushViewController(SuccessViewController(), animated: true)
                    } else {
                        if let err = authenticationError as? LAError {
                            print("Error--------: ", self.handleError(error: err))
                            let ac = UIAlertController(title: "Login failed", message: self.handleError(error: err), preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default))
                            self.present(ac, animated: true)
                        }
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Touch ID not available", message: "Your device is not configured for Touch ID.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    func handleError(error:LAError) -> String {
        var message = ""
        switch error.code {
        case LAError.authenticationFailed:
            message = "Authentication was not successful because the user failed to provide valid credentials."
            break
        case LAError.userCancel:
            message = "Authentication was canceled by the user"
            break
        case LAError.userFallback:
            message = "Authentication was canceled because the user tapped the fallback button"
            break
        case LAError.touchIDNotEnrolled:
            message = "Authentication could not start because Touch ID has no enrolled fingers."
        case LAError.passcodeNotSet:
            message = "Passcode is not set on the device."
            break
        case LAError.systemCancel:
            message = "Touch ID may not be configured"
            break
        default:
            message = error.localizedDescription
        }
        return message
    }
    
    
    func showAlertLoginFail() {
        let ac = UIAlertController(title: "Login failed", message: "Sorry!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(ac, animated: true)
    }

    @IBAction func loginBtnDidTap(_ sender: Any) {
        if let username = usernameTextField.text, let pass = passTextField.text {
            if login(username: username, password: pass) {
                self.navigationController?.pushViewController(SuccessViewController(), animated: true)
            } else {
                self.showAlertLoginFail()
            }
        }
    }
    
    @IBAction func touchIDButtonDidTap(_ sender: Any) {
        loginWithTouchID()
    }
}

