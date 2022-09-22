//
//  ContentView.swift
//  faceIDtest1
//
//  Created by Qiwei on 9/21/22.
//

//state struct vs binding struct - $binding struct is the visible portion of the state struct, it is the computed version of it

import SwiftUI

struct ContentView: View {
    @StateObject var authenticationManager = AuthenticationManager()
    
    var body: some View {
        //filling content view entirely with login view 
        NavigationView {
            VStack {
                LoginView().environmentObject(authenticationManager)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .alert(isPresented:
                $authenticationManager.showAlert){
                Alert(title: Text("Error"), message:
                        Text(authenticationManager.errorDescription ?? "Error trying to log in, please try again"), dismissButton: .default(Text("OK")))
        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
