//
//  HomeDefaultScreenView.swift
//  Tapper
//
//  Created by Yazan Tarifi on 08/01/2024.
//

import SwiftUI

struct HomeDefaultScreenView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Image(systemName: "house")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                
                VStack(alignment: .leading) {
                    Text("Tapper")
                        .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    
                    Text("Android Testing Platform")
                        .foregroundColor(TapperUtils.shared.getTextSecondColor())
                }
                .padding()
            }
            .padding()
            
            VStack {
                Text("Welcome To Tapper UI Application To Control Your Android Devices")
                    .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
                    .font(.title2)
            }
            .padding()
            .padding(.top, 10)
        }
    }
}

#Preview {
    HomeDefaultScreenView()
}
