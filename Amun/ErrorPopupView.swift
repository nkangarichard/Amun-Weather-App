//
//  ErrorPopupView.swift
//  Amun
//
//  Created by Richard Nkanga on 22/05/2024.
//

import SwiftUI

struct ErrorPopupView: View {

    let errorMessage: String
    var body: some View {

                 Text(errorMessage)
                     .font(.custom("Avenir-Black", size: 17))
                     .foregroundColor(.white)
                     .padding()
                     .background(Color.red)
                     .cornerRadius(10)
                     .padding(.horizontal, 40)
                     .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
             
    }
       
}

#Preview {
    ErrorPopupView(errorMessage: "The location 'Invalid' could not be found.")
               .previewLayout(.sizeThatFits)
}
