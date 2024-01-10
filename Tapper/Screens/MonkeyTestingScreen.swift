//
//  MonkeyTestingScreen.swift
//  Tapper
//
//  Created by Yazan Tarifi on 10/01/2024.
//

import SwiftUI

struct MonkeyTestingScreen: View {
    var body: some View {
        VStack {
            Text("Monkey")
        }
        .frame(width: 500, height: 500)
        .padding()
        .background(TapperUtils.shared.getApplicationPrimaryColor())
    }
}

#Preview {
    MonkeyTestingScreen()
}
