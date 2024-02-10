//
//  TestView.swift
//  Amun
//
//  Created by Richard Nkanga on 09/02/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Text("thi si the home view")
                .navigationBarBackButtonHidden(true)
        }
        .background(Color.red)
    }
}

#Preview {
    HomeView()
}
