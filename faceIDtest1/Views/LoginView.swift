//
//  LoginView.swift
//  faceIDtest1
//
//  Created by Qiwei on 9/22/22.
//

//ln 24 wrap in task init to bypass trying to call async inside sync issue

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authenticationManager: AuthenticationManager
    
    var body: some View {
        VStack(spacing: 40){
            Title()
            
            //toggle between none, touch, face id
            switch
                authenticationManager.biometryType {
            case .faceID:
                PrimaryButton(image:"faceid", text: "Login with FaceID")
                    .onTapGesture{
                        Task.init{
                            await authenticationManager.authenticatedWithBiometrics()
                        }
                    }
            case .touchID:
                PrimaryButton(image:"touchid", text: "Login with TouchID")
                    .onTapGesture{
                        Task.init{
                            await authenticationManager.authenticatedWithBiometrics()
                        }
                    }
            default: //use navigation bc this leads us to a completely different view
                NavigationLink{
                    CredentialsLoginView().environmentObject(authenticationManager)
                } label: {
                    PrimaryButton(image:"person.fill", text: "Login with your credentials")
                }
               
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
