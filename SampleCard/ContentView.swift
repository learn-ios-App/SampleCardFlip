//
//  ContentView.swift
//  SampleCard
//
//  Created by 渡邊魁優 on 2023/09/14.
//

import SwiftUI

struct Flip<Front: View, Back: View>: View {
    var isFront: Bool
    @State var canShowFrontView: Bool
    let duration: Double
    let front: () -> Front
    let back: () -> Back
    
    init(isFront: Bool,
         duration: Double = 1.0,
         @ViewBuilder front: @escaping () -> Front,
         @ViewBuilder back: @escaping () -> Back) {
        self.isFront = isFront
        self._canShowFrontView = State(initialValue: isFront)
        self.duration = duration
        self.front = front
        self.back = back
    }
    
    var body: some View {
        VStack {
            ZStack {
                if self.canShowFrontView {
                    front()
                }
                else {
                    back()
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 1, z: 0))
                }
            }
            .onChange(of: isFront, perform: {
                value in
                DispatchQueue.main.asyncAfter(deadline: .now() + duration/2.0) {
                    self.canShowFrontView = value
                }
            })
            .rotation3DEffect(isFront ? Angle(degrees: 0): Angle(degrees: 180), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))

            Button(action: {
                self.canShowFrontView.toggle()
            }) {
                Text("flip")
            }
        }
    }
}


struct Front: View {
    var body: some View {
        Text("Front")
    }
}


struct Back: View {
    var body: some View {
        Text("Back")
    }
}


struct ContentView: View {
    var body: some View {
        Flip(isFront: false, front: {
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
