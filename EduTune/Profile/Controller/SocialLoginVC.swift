//
//  SocialLoginVC.swift
//  BOOM SOCCER
//
//  Created by Mostafizur Rahman on 26/5/20.
//  Copyright © 2020 PEEMZ. All rights reserved.
//

import UIKit
import GoogleSignIn
import AuthenticationServices
import CryptoKit
import SwiftyJSON

class SocialLoginVC: UIViewController {
    
    fileprivate var currentNonce: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func startGoogleSignIn() {
        
        let signInConfig = GIDConfiguration.init(clientID: GOOGLECLIENTID)
        
//        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
//            guard error == nil else {
//                self.showErrorMessage(error)
//                return
//            }
//            self.signUp(user?.profile?.email ?? "", socialId: user?.userID ?? "", name: user?.profile?.name)
//        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    func showErrorMessage(_ error: Error?) {
        if let message = error?.localizedDescription {
            print(message)
            MakeToast.shared.makeNormalToast(message)
        } else {
            MakeToast.shared.makeNormalToast("An error has occurred!")
        }
    }
    
    func signUp(_ email: String, socialId: String, name: String?) {
        
        var params = [String: Any]()
        params["email"] = email
        params["social_id"] = socialId
        params["fullname"] = name
        
//        APIService.shared.socialLogin(params) { (user) in
//            if let user = user {
//                SocketClient.shared.user = user
//                AppUserDefault.setPicture(user.picture ?? "")
//                AppUserDefault.setUserId(user.id ?? -1)
//
//                if user.studentCategoryId != nil {
//                    if let viewC: TabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC {
//                        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController = viewC
//                        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.makeKeyAndVisible()
//                    }
//                } else {
//                    if let viewC: SelectCategoryVC = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "SelectCategoryVC") as? SelectCategoryVC {
//                        viewC.fullname = user.fullname ?? ""
//                        self.navigationController?.pushViewController(viewC, animated: true)
//                    }
//                }
//            }
//        }
    
    }
}

extension SocialLoginVC {
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if length == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
}

extension SocialLoginVC: ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding {
    
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    @available(iOS 13, *)
    func startSignInWithAppleFlow() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}

@available(iOS 13.0, *)
extension SocialLoginVC {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let _ = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            
            let givenName = appleIDCredential.fullName?.givenName ?? ""
            let familyName = appleIDCredential.fullName?.familyName ?? ""
            
            signUp(appleIDCredential.email ?? "", socialId: appleIDCredential.user, name: (givenName+" "+familyName).trim)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("Sign in with Apple errored: \(error)")
    }
    
}
