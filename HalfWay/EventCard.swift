//
//  EventCard.swift
//  HalfWay
//
//  Created by brady murphy on 12/28/19.
//  Copyright © 2019 Brady Murphy. All rights reserved.
//

import SwiftUI

struct EventCard: View {
    // let event: Event
    var body: some View {
        ZStack {
            // event background image
            Image("event")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width / 1.75, height: UIScreen.main.bounds.width / 2.5)
                .clipped() // clip to fit the frame
                .overlay(
                    LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)
            )
            
            
            // caption for event
            VStack {
                Spacer()
                HStack {
                    Text("Event Title")
                        .font(.title)
                        .lineLimit(1)
                    Spacer()
                }
                // caption of text
                HStack {
                    Text("$$ | Entertainment")
                        .font(.caption)
                        .lineLimit(1)
                    Spacer()
                }
            }
            .foregroundColor(.white)
            .padding([.leading, .bottom])
            .frame(width: UIScreen.main.bounds.width / 1.75, height: UIScreen.main.bounds.width / 2.5)
            
        }
        .cornerRadius(15)
        .shadow(color: .primary, radius: 4, x: 0, y: 2)
        
    }
}

struct EventCard_Previews: PreviewProvider {
    static var previews: some View {
        EventCard()
    }
}
