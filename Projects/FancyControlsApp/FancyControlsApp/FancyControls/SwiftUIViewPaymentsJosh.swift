//
//  SwiftUIViewPaymentsJosh.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 15/12/22.
//

import SwiftUI

struct SwiftUIViewPaymentsJosh: View {
    var colorArray: [String] = ["#C46B33", "#1960CC", "#C25A99"]
    var body: some View {
        ZStack (alignment: .top) {
            VStack {//START: VSTACK Outer Container
                HStack { //START: HSTACK Josh wallet details
                    VStack(alignment: .leading) { //START: VSTACK left side of wallet details
                        Text("Josh Wallet")
                            .foregroundColor(Color(uiColor: hexStringToUIColor(hex: "#BBBFC5")))
                            .font(.system(size: 14))
                        HStack {
                            Image(systemName: "gear")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.orange)
                            
                            Spacer()
                            
                            Text("514")
                                .foregroundColor(.white)
                                .font(.system(size: 24))
                        }
                        .frame(width: 80)
                    } //END: VSTACK left side of wallet details
                    Spacer()
                    
                    VStack(alignment: .trailing) { //START: VSTACK right side of wallet details
                        Button {
                            
                        } label: {
                            Text("Redeem")
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                                .frame(width: 72, height: 28)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(.white, style: StrokeStyle(lineWidth: 1))
                                        .frame(width: 72, height: 28)
                                }
                            
                        }
                        Spacer()
                        HStack(spacing: 4) {
                            Image(systemName: "gear")
                                .resizable()
                                .frame(width: 15, height: 15)
                            Text("200 worth")
                            Text("Rs20")
                        }
                        .foregroundColor(.white)
                        .font(.system(size: 12))
                        
                    } //END: VSTACK right side of wallet details
                } //END: HSTACK Josh wallet details
                .padding(.horizontal)
                .frame(height: 54)
                
                Rectangle()
                    .fill(.clear)
                    .frame(width: .infinity, height: 80)
                
                Capsule()
                    .fill(Color(uiColor: hexStringToUIColor(hex: "#D8D8D8")))
                    .opacity(0.3)
                    .frame(width: .infinity, height: 1)
                    .padding(.horizontal)
                
                HStack {
                    Text("Transaction history")
                    Text("1 Pending")
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                        .background {
                            Capsule()
                                .fill(.black)
                        }
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(.white)
                .font(.system(size: 12))
                .padding(.top, 12)
                .padding(.horizontal)
            } //END: VSTACK Outer Container
            .frame(width: .infinity, height: 234)
            .background {
                LinearGradient(colors: [Color(uiColor: hexStringToUIColor(hex: "#2C2F52")), Color(uiColor: hexStringToUIColor(hex: "#0A0F3F"))], startPoint: .topLeading, endPoint: .bottomTrailing)
            }
            .cornerRadius(8)
            .padding(.horizontal)
            
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(colorArray, id: \.self) { color in
                            JemsTransactionChips(color: color)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
                .frame(width: .infinity, height: 80)
            }
            .frame(width: .infinity, height: 234)
        }
    }
}

struct JemsTransactionChips: View {
    var color: String
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white.opacity(0.2))
                .frame(width: 30, height: 54)
                .overlay {
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 14, height: 14)
                }
                
            
            VStack(alignment: .leading) {
                Text("Performance Payouts")
                    .font(.system(size: 12))
                Spacer()
                
                HStack(spacing: 4) {
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 15, height: 15)
                    Text("100")
                        .font(.system(size: 13))
                }
                .opacity(0.5)
            }
            .frame(width: 80, height: 54)
        }
        .foregroundColor(.white)
        .frame(width: 139, height: 80)
        .background {
            Color(uiColor: hexStringToUIColor(hex: color))
                .cornerRadius(10)
        }
    }
}

struct SwiftUIViewPaymentsJosh_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewPaymentsJosh()
    }
}

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
