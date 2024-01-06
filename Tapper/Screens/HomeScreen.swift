//
//  HomeScreen.swift
//  Tapper
//
//  Created by Yazan Tarifi on 06/01/2024.
//

import SwiftUI

struct HomeScreen: View {
    
    @StateObject private var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        HStack {
            // Side Bar Controller
            VStack(alignment: .leading) {
                
                // Application Banner
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
                    .padding(.leading, 8)
                    .padding(.trailing, 8)
                    .padding(.top, 30)
                    
                    // Add New Applications Label
                    HStack(alignment: .center) {
                        Text("Applications")
                            .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
                        
                        Image("AddImage")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 10)
                    .padding(.leading, 8)
                    .padding(.trailing, 8)
                    
                    // Applications List
                    ScrollView {
                        LazyVStack(alignment: .leading) {
                            ForEach(viewModel.applicationsList, id: \.self.id) { app in
                                TapperAppCellView(application: app)
                            }
                            
                            Spacer()
                        }
                    }
                    .frame(height: 300)
                }
                
                Spacer()
                
                // Bottom Shortcuts Content
                LazyVStack {
                    ForEach(viewModel.commandsList, id: \.self.id) { command in
                        TapperCommandView(command: command)
                    }
                }
                .padding(.leading, 4)
                
                Spacer()
            }
            .frame(width: 260)
            .background(TapperUtils.shared.getApplicationPrimaryColor())
            .ignoresSafeArea(.all)
            .padding(.leading, 4)
            
            // Screen Content
            ZStack {
                
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            .background(TapperUtils.shared.getApplicationSecondColor())
        }
        .ignoresSafeArea(.all)
        .background(TapperUtils.shared.getApplicationPrimaryColor())
        .frame(width: 1280, height: 720)
    }
}

#Preview {
    HomeScreen()
}
