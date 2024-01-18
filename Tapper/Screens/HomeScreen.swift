//
//  HomeScreen.swift
//  Tapper
//
//  Created by Yazan Tarifi on 06/01/2024.
//

import SwiftUI

struct HomeScreen: View {
    
    @Environment(\.openURL) var openUrl
    @State private var isApplicationCreationDialogShown = false
    @State private var isApplicationSettingsDialogShown = false
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
                            .onTapGesture {
                                isApplicationCreationDialogShown = true
                            }
                    }
                    .padding(.top, 10)
                    .padding(.leading, 8)
                    .padding(.trailing, 8)
                    
                    // Applications List
                    ScrollView {
                        LazyVStack(alignment: .leading) {
                            ForEach(viewModel.applicationsList, id: \.self.id) { app in
                                TapperAppCellView(application: app)
                                    .onTapGesture {
                                        viewModel.onSelectApp(app: app)
                                    }
                            }
                            
                            Spacer()
                        }
                    }
                    .frame(height: 260)
                }
                
                Spacer()
                
                // Bottom Shortcuts Content
                LazyVStack {
                    ForEach(viewModel.commandsList, id: \.self.id) { command in
                        TapperCommandView(command: command).onTapGesture {
                            if command.command == TapperConsts.EXECUTE_SETTINGS {
                                isApplicationSettingsDialogShown = true
                            } else if command.command == TapperConsts.EXECUTE_MONKEY_TESTING {
                                guard let url = URL(string: "tapper://\(TapperConsts.MONKEY_TESTING_DEEPLINK_KEY)/\(viewModel.getSelectedApplication()?.packageName ?? "")") else {
                                    return
                                }
                                
                                openUrl(url)
                            } else if command.command == TapperConsts.EXECUTE_GENERAL_SETTINGS {
                                guard let url = URL(string: "tapper://\(TapperConsts.GENERAL_DEEPLINK_KEY)") else {
                                    return
                                }
                                
                                openUrl(url)
                            } else if command.command == TapperConsts.EXECUTE_TESTING_EVENTS {
                                guard let url = URL(string: "tapper://\(TapperConsts.TESTING_DEEPLINK_KEY)") else {
                                    return
                                }
                                
                                openUrl(url)
                            } else if command.command == TapperConsts.EXECUTE_DEVELOPER_SETTINGS {
                                guard let url = URL(string: "tapper://\(TapperConsts.DEVELOPER_DEEPLINK_KEY)") else {
                                    return
                                }
                                
                                openUrl(url)
                            }
                        }
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
            VStack {
                VStack {
                    switch viewModel.selectedScreenView {
                    case .Default:
                        HomeDefaultScreenView()
                    case .TestScenario:
                        TestScenarioScreen(viewModel: viewModel)
                    case .Application:
                        HomeApplicationView(viewModel: viewModel)
                    case .NotSet:
                        VStack {
                            ProgressView()
                                .colorInvert()
                                .progressViewStyle(CircularProgressViewStyle(
                                    tint: TapperUtils.shared.getTextPrimaryColor())
                                )
                                .foregroundColor(
                                    TapperUtils.shared.getTextPrimaryColor()
                                )
                                .padding(.bottom, 4)
                            
                            Text("Loading, Please Wait ...")
                                .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                
                Spacer()
                
                HomeBottomStatusBarView(viewModel: self.viewModel)
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            .background(TapperUtils.shared.getApplicationSecondColor())
        }
        .ignoresSafeArea(.all)
        .background(TapperUtils.shared.getApplicationPrimaryColor())
        .frame(width: 1280, height: 720)
        .onAppear {
            viewModel.getApplications()
        }
        .sheet(isPresented: $isApplicationCreationDialogShown) {
            ApplicationCreationDialogView(
                isPresented: $isApplicationCreationDialogShown, 
                viewModel: viewModel
            )
        }
        .sheet(isPresented: $isApplicationSettingsDialogShown) {
            ApplicationSettingsDialog(
                isPresented: $isApplicationSettingsDialogShown,
                viewModel: viewModel
            )
        }
    }
}
