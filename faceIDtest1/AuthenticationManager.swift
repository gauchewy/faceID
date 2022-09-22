//
//  AuthenticationManager.swift
//  faceIDtest1
//
//  Created by Qiwei on 9/22/22.
//

import Foundation
import LocalAuthentication

class AuthenticationManager: ObservableObject {
    private(set) var context = LAContext()
    @Published private(set) var biometryType: LABiometryType = .none
    private(set) var canEvaluatePolicy = false
    @Published private(set) var isAuthenticated = false
    @Published private(set) var errorDescription: String?
    @Published var showAlert = false
    
    init() {
        getBiometryType()
    }
    
    func getBiometryType(){
        context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        biometryType = context.biometryType
    }
    
    func authenticatedWithBiometrics() async {
        context = LAContext() //reassigning the context each time user attempts to login ... this seems important for specifc usage
        
        if canEvaluatePolicy{
            let reason = "to log in to your account"
            
            do{
                //this will throw a boolean
                let success = try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason)
                
                if success {
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                        print("is authenticated", self.isAuthenticated)
                    }
                }
            }
            catch{ //if fail to authenticate, throw an error, show it, no biometry
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.errorDescription = error.localizedDescription
                    self.showAlert = true
                    self.biometryType = .none
                }
            }
        }
        
    }
    
    func authenticateWithCredentials(username: String, password: String){
        if username.lowercased() == "qiwei" && password == "1234" {
            isAuthenticated = true
        }
        else{
            isAuthenticated = false
            showAlert = true
        }
    }
}
