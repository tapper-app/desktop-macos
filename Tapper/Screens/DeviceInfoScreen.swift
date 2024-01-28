//
//  DeviceInfoScreen.swift
//  Tapper
//
//  Created by Yazan Tarifi on 28/01/2024.
//

import SwiftUI

struct DeviceInfoScreen: View {
    
    @State private var list: [String] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Device Information")
                    .font(.title)
                    .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
                
                Spacer()
            }
            
            HStack {
                Text("This Screen Will Disable The Device Info You Need to See on the Connected Device")
                    .font(.caption)
                    .foregroundColor(TapperUtils.shared.getTextSecondColor())
                
                Spacer()
            }
            
            if !list.isEmpty {
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(list, id: \.self) { item in
                            let commandFragments = item.split(separator: "=")
                            HStack(alignment: .top)  {
                                HStack {
                                    Text(commandFragments[0])
                                        .font(.caption)
                                        .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
                                    
                                    Spacer()
                                }
                                .frame(width: 200)
                                
                                HStack {
                                    Text("Value : " + commandFragments[1])
                                        .font(.caption)
                                        .foregroundColor(TapperUtils.shared.getTextSecondColor())
                                    
                                    Spacer()
                                }
                                .frame(width: 250)
                                
                                Spacer()
                            }
                        }
                        
                        Spacer()
                    }
                }
            } else {
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Text("No Data Available ...")
                            .foregroundColor(TapperUtils.shared.getRedColor())
                            .font(.title3)
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
            }
            
        }
        .padding()
        .frame(width: 550, height: 600)
        .background(TapperUtils.shared.getApplicationPrimaryColor())
        .onAppear {
            DispatchQueue.global(qos: .background).async {
                let commandResult = TapperUtils.shared.onExecuteTapperCommandWithResult(
                    command: TapperConsts.EXECUTE_DEVICE_INFO
                )
                
                let commandsList = commandResult.split(separator: "\n")
                var commandsToShow: [String] = []
                commandsList.forEach { line in
                    if line.contains("=") && !line.contains("====") {
                        commandsToShow.append(String(line))
                    }
                }
                
                DispatchQueue.main.async {
                    self.list = commandsToShow
                }
            }
        }
    }
}

#Preview {
    DeviceInfoScreen()
}
