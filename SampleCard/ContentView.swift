//
//  ContentView.swift
//  SampleCard
//
//  Created by 渡邊魁優 on 2023/09/14.
//

import SwiftUI

struct Flip<Front: View, Back: View>: View {
    @State var isFront: Bool
    let front: () -> Front
    let back: () -> Back
    
    var body: some View {
        VStack {
            ZStack {
//                RoundedRectangle(cornerRadius: 25)
//                    .fill(Color.white)
//                    .frame(width: 300, height: 200)
                if self.isFront {
                    front()
                        .rotationEffect(.degrees(180))
                        .scaleEffect(x: -1, y: 1, anchor: .center)
                }
                else {
                    back()
                }
            }
            .rotation3DEffect(.degrees(isFront ? 180 : 0),
                                      axis: (x: 1, y: 0, z: 0))
            .animation(.spring(response: 0.7, dampingFraction: 10, blendDuration: 0),
                       value: isFront)
        }
        .onTapGesture {
            self.isFront.toggle()
        }
    }
}


struct Front: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.white)
            .frame(width: 300, height: 200)
            .shadow(radius: 5)
            .overlay(
                VStack {
                    Spacer()
                    Text("Front")
                        .font(.largeTitle)
                    Spacer()
                    Text("表面です")
                    Spacer()
                }
            )
    }
}


struct Back: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.white)
            .frame(width: 300, height: 200)
            .shadow(radius: 5)
            .overlay(
                VStack {
                    Spacer()
                    Text("Back")
                        .font(.largeTitle)
                    Spacer()
                    Text("裏面です")
                    Spacer()
                }
            )
    }
}


struct ContentView: View {
    var body: some View {
        Flip(isFront: true, front: {
            Front()
        }, back: {
            Back()
        })
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
