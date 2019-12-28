//
//  ContentView.swift
//  HalfWay
//
//  Created by brady murphy on 12/21/19.
//  Copyright © 2019 Brady Murphy. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // use geomtry reader to
        VStack(alignment: .leading) {
            Text("Results")
                .font(.title)
                .foregroundColor(.primary)
                .padding(.leading)
                
            VStack(alignment: .leading) {
                Text("Enterainment")
                    .padding(.leading)
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .offset(y: 12)
                
                ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(0..<10) { index in
                                EventCard()
                            }
                        }
                        .frame(height: 170)
                        .padding(.leading)
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
