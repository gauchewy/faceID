//
//  Title.swift
//  faceIDtest1
//
//  Created by Qiwei on 9/21/22.
//

import SwiftUI

struct Title: View {
    var body: some View {
        Text("Face ID Authenticator")
            .bold()
            .font(.title)
            .foregroundColor(.white)
    }
}

struct Title_Previews: PreviewProvider {
    static var previews: some View {
        Title()
            .background(LinearGradient(
                colors:[.pink,.purple],
                startPoint:.topLeading,
                endPoint: .bottomTrailing))
    }
}
