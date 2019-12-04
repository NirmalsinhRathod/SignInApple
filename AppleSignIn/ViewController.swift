//
//  ViewController.swift
//  AppleSignIn
//
//  Created by Nirmalsinh on 02/12/19.
//  Copyright © 2019 Nirmalsinh. All rights reserved.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         self.setupSOAppleSignIn()
    }

    func setupSOAppleSignIn() {

        if #available(iOS 13.0, *) {
            let btnAuthorization = ASAuthorizationAppleIDButton()
            btnAuthorization.frame = CGRect(x: 0, y: 0, width: 200, height: 40)

                   btnAuthorization.center = self.view.center

                   btnAuthorization.addTarget(self, action: #selector(actionHandleAppleSignin), for: .touchUpInside)

                   self.view.addSubview(btnAuthorization)
        } else {
            // Fallback on earlier versions
        }
    }
    @objc func actionHandleAppleSignin() {

        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()

            request.requestedScopes = [.fullName, .email]

            let authorizationController = ASAuthorizationController(authorizationRequests: [request])

            authorizationController.delegate = self as ASAuthorizationControllerDelegate

            authorizationController.presentationContextProvider = self

            authorizationController.performRequests()
        } else {
            // Fallback on earlier versions
        }

    }
}

extension ViewController: ASAuthorizationControllerDelegate {

     // ASAuthorizationControllerDelegate function for authorization failed

    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {

        print(error.localizedDescription)

    }

       // ASAuthorizationControllerDelegate function for successful authorization

    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {

        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {

            // Create an account as per your requirement

            let appleId = appleIDCredential.user
            let appleUserFirstName = appleIDCredential.fullName?.givenName
            let appleUserLastName = appleIDCredential.fullName?.familyName
            let appleUserEmail = appleIDCredential.email
            
            let label = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 21))
            label.center = CGPoint(x: 160, y: 285)
            label.textAlignment = .center
            label.text = appleIDCredential.email
            self.view.addSubview(label)

        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {

            let appleUsername = passwordCredential.user
            let applePassword = passwordCredential.password

            //Write your code

        }

    }

}

extension ViewController: ASAuthorizationControllerPresentationContextProviding {

    //For present window

    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {

        return self.view.window!

    }

}
