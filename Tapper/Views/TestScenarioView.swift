//
//  TestScenarioView.swift
//  Tapper
//
//  Created by Yazan Tarifi on 10/01/2024.
//

import SwiftUI

struct TestScenarioView: View {
    
    let testScenario: TapperTestScenarioModel
    init(testScenario: TapperTestScenarioModel) {
        self.testScenario = testScenario
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(testScenario.name)
                        .foregroundColor(TapperUtils.shared.getTextPrimaryColor())
                        .font(.title2)
                        .padding(.bottom, 5)
                    
                    Spacer()
                }
                
                HStack {
                    Text(testScenario.testDescription)
                        .foregroundColor(TapperUtils.shared.getTextSecondColor())
                        .font(.title3)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                }
            }
            
            VStack(alignment: .center) {
                Image("MoreImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 10, height: 10)
                    .padding(4)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image("RightArrow")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 10, height: 10)
                    .padding(4)
                    .foregroundColor(.white)
            }
        }
        .background(TapperUtils.shared.getApplicationPrimaryColor())
        .cornerRadius(10)
        .padding()
    }
}
