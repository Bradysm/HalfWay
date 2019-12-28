//
//  ExitButton.swift
//  HalfWay
//
//  Created by brady murphy on 12/28/19.
//  Copyright © 2019 Brady Murphy. All rights reserved.
//

import SwiftUI

/**
 Circular exit button. When clicked, the button will dismiss the current view from the stack
 */
struct ExitButton: View {
    var body: some View {
        Button(action: {
            print("Pressed exit button")
        }){
            Image(systemName: "multiply")
                .resizable()
                .frame(width: 16, height: 16)
                .padding(10)
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color("RoyalBlue"), Color("Teal")]), startPoint: .top, endPoint: .bottom))
                .mask(Circle())
        }
        .buttonStyle(PlainButtonStyle())
        .shadow(color: .primary, radius: 4, x: 0, y: 2)
        
    }
}

struct ExitButton_Previews: PreviewProvider {
    static var previews: some View {
        ExitButton()
    }
}
