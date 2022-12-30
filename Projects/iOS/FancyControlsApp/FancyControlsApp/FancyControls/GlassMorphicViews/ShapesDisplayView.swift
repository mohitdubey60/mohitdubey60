    //
    //  ShapesDisplayView.swift
    //  FancyControlsApp
    //
    //  Created by mohit.dubey on 07/12/22.
    //

import SwiftUI

struct ShapesDisplayView: View {
    @State var pacManAnimation = false
    @State var moveRight = false
    @State var moveLeft = false
    var backgroundColor: Color = .clear
    
    private var content: some View {
        VStack {
            
//            TrapezoidShape(xLeft: moveLeft ? 0.4 : 0, xRight: moveRight ? 0 : 0.4)
            TrapezoidShape()
                .fill(LinearGradient(colors: [Color.black, Color.gray], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 400, height: 50)
                .background(backgroundColor)
//                .onAppear {
//                    withAnimation(Animation.linear(duration: 1)) {
//                        moveRight = true
//                    }
//
//                    withAnimation(Animation.linear(duration: 1)) {
//                        moveLeft = true
//                    }
//                }
            
            Spacer()
            
            PacmanShape(mouthAngle: pacManAnimation ? 20 : 0)
                .fill(LinearGradient(colors: [Color.yellow, Color.orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 100, height: 100)
                .onAppear {
                    withAnimation(Animation.easeIn(duration: 0.2).repeatForever()) {
                        pacManAnimation.toggle()
                    }
                }
                .background(backgroundColor)
            
            Spacer()
            
            TopRoundedCornerRectangleShape(radius: 20)
                .fill(LinearGradient(colors: [Color.blue, Color.cyan], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 400, height: 50)
                .background(backgroundColor)
            
            
            Spacer()
            
            WaveShape()
                .fill(LinearGradient(colors: [Color.blue, Color(uiColor: UIColor.systemTeal)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(height: 200)
                .background(backgroundColor)
            
            Spacer()
            
            WaterShape()
                .fill(LinearGradient(colors: [Color.blue, Color.purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(height: 300)
                .background(backgroundColor)
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    
                    content
                    
                }
                .frame(minHeight: geometry.frame(in: .global).height)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct ShapesDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        ShapesDisplayView()
    }
}
