//
//  HomeDefaultScreenView.swift
//  Tapper
//
//  Created by Yazan Tarifi on 08/01/2024.
//

import SwiftUI

struct HomeDefaultScreenView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Image("Logo")
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
                    
                    Spacer()
                }
                .padding()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Welcome To Tapper UI Application To Control Your Android Devices")
                            .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
                            .font(.title2)
                            .padding(.top, 3)
                        
                        Text("Tapper is an Opensource Application Built to test Android Applications With GUI Application on Several Plarforms with the Ability to Control Developer Options on Your Android Device")
                            .foregroundColor(TapperUtils.shared.getTextSecondColor())
                            .font(.title3)
                            .frame(maxWidth: 550)
                            .padding(.top, 1)
                        
                        Text("To Start Using Tapper You need to Create an Application then Use Tapper Functions")
                            .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
                            .font(.title3)
                            .padding(.top, 7)
                        
                        Text("Tapper also Available on Terminal without UI if you want to use Tapper write in your Terminal tapper then enter to open selection picker and for short commands see help section in the cli")
                            .foregroundColor(TapperUtils.shared.getTextSecondColor())
                            .font(.title3)
                            .frame(maxWidth: 550)
                            .padding(.top, 7)
                        
                        Text("Tapper Application Configurations")
                            .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
                            .font(.title3)
                            .padding(.top, 5)
                        
                        Text("Tapper Cant Directly Access the Installed Environment Variables on your Device before you start with any application open settings tab and add the paths of your environment variables on your device then save them")
                            .foregroundColor(TapperUtils.shared.getTextSecondColor())
                            .font(.title3)
                            .frame(maxWidth: 550)
                            .padding(.top, 7)
                        
                        Text("More Information")
                            .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
                            .font(.title3)
                            .padding(.top, 5)
                        
                        Text("For More Information about Available Options, Commands Please Visit the Website (https://tapperapp.com)")
                            .foregroundColor(TapperUtils.shared.getTextSecondColor())
                            .font(.title3)
                            .padding(.top, 7)
                    }
                    
                    Spacer()
                }
                .padding()
                .padding(.top, 5)
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
    }
}

#Preview {
    HomeDefaultScreenView()
}
