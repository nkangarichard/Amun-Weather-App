//
//  InputView.swift
//  Amun
//
//  Created by Richard Nkanga on 25/03/2024.
//

import SwiftUI

struct InputView: View {

    @Environment(\.dismiss) var dismiss
    @State var location = ""

    var body: some View {

        NavigationStack {
            ZStack {
                Color(.background)
                    .ignoresSafeArea(.all)
                VStack (spacing:35){




//                    HStack {
//
//                        Text("Add A Location")
//                            .font(.custom("Avenir-Black", size: 30))
//                            .foregroundStyle(.text)
//
//
//                        Spacer()
//
//                        Button(action: {
//
//
//                            dismiss()
//
//                        
//
//                        }) {
//                            Image(systemName: "xmark")
//                                .font(Font.custom("Avenir", size: 17.59).weight(.heavy))
//                                .frame(width: 60, height: 60, alignment: .center)
//                                .background(
//                                    Circle()
//                                        .frame(width: 50, height: 50)
//                                        .foregroundStyle(.greyShadow)
//                                        .offset(x: -4, y: 3)
//                                        .overlay(
//                                            Circle()
//                                                .frame(width: 50, height: 50)
//                                                .foregroundStyle(.text)
//                                        )
//                                )
//                                .foregroundColor(.textColorInversed)
//                                .cornerRadius(9)
//                                .padding(.bottom, 30)
//                    }
//                    }
//                    .padding()







                    TextField("Name of City or Country", text: $location)
                        .padding()
                        .frame(width: 350, height: 67)
                        .background {
                            ZStack {
                                Rectangle()
                                    .frame(width: UIScreen.main.bounds.width - 40, height: 85)
                                    .foregroundStyle(Color(.greyShadow))
                                    .offset(y: 1)


                                Rectangle()
                                    .frame(width: UIScreen.main.bounds.width  - 40, height: 85)
                                    .foregroundStyle(Color(.weatherHolder))
                            }
                        }
                        .padding(.bottom, 15)
                        .shadow(color: .black.opacity(0.1), radius: 30, x: 0, y: 5)





                    Button(action: {

                        dismiss()


                    }, label: {
                        Text(location.isEmpty ? "Next" : "Get Started")
                            .font(.custom("Avenir-Black", size: 17))
                            .frame(width: 260, height: 60, alignment: .center)

                            .background {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 260, height: 60)
                                        .foregroundStyle(.greyShadow)
                                        .offset(x: -6, y: 6)

                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 260, height: 60)
                                        .foregroundStyle(.text)
                                }
                            }
                            .foregroundColor(.textColorInversed)



                    })



                    Spacer()




                }
                .padding()
            }
            .navigationTitle("Add Loacation")
            .toolbar {


                ToolbarItem {
                    Button(action: {

                        dismiss()

                    }) {
                        Image(systemName: "xmark")
                            .font(Font.custom("Avenir", size: 10.59).weight(.heavy))
                            .frame(width: 40, height: 40, alignment: .center)
                            .background(
                                ZStack {
                                    Circle()
                                        .frame(width: 30, height: 30)
                                        .foregroundStyle(.greyShadow)
                                        .offset(x: -4, y: 3)

                                    Circle()
                                        .frame(width: 30, height: 30)
                                        .foregroundStyle(.text)
                                }
                            )
                            .foregroundColor(.textColorInversed)
                            .cornerRadius(9)
                    }
                }


                
            }
        }
    }
}

#Preview {
    InputView()
}
