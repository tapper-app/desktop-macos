//
//  SplashScreen.swift
//  Tapper
//
//  Created by Yazan Tarifi on 06/01/2024.
//

import SwiftUI

struct SplashScreen: View {
    
    private let listener: SplashScreenNavigationListener
    init(listener: SplashScreenNavigationListener) {
        self.listener = listener
    }
    
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Image(systemName: "house")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
                        
                    
                    Text("Tapper")
                        .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
                        .font(.title)
                    
                    Text("Android Apps Testing Platform")
                        .foregroundColor(TapperUtils.shared.getTextSecondColor())
                        .font(.title2)
                    
                    Text("Automate, Change Developer Options In Your Android Applications Without Writing Code")
                        .foregroundColor(TapperUtils.shared.getTextSecondColor())
                        .font(.title3)
                }
                .padding()
                
                Spacer()
            }
            
            Spacer()
            
            HStack(alignment: .center) {
                Spacer()
                Image("RightArrow")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .padding(4)
                    .background(TapperUtils.shared.getAccentColor())
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .onTapGesture {
                        listener.onNavigateScreen()
                    }
                    
                
            }
            .padding()
        }
        .padding()
        .frame(width: 1280, height: 720)
        .background(TapperUtils.shared.getApplicationPrimaryColor())
    }
}
