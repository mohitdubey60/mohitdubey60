    //
    //  ContactsDetails.swift
    //  FancyControlsApp
    //
    //  Created by mohit.dubey on 05/12/22.
    //

import SwiftUI
import MapKit

struct ContactsDetails: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @State private var phoneNumber = "+919999999999"
    @State private var isBlurEnabled = false
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                            //Name and Image
                        HStack {
                            Image("Diljit2")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                Text("Diljit Dosanj")
                                    .font(.title)
                                    .bold()
                                Spacer()
                                HStack {
                                    Text("Phone:")
                                        .bold()
                                    Spacer()
                                    Text(phoneNumber)
                                        .foregroundColor(.secondary)
                                        .frame(minWidth: 150)
                                }
                                HStack {
                                    Text("Email:")
                                        .bold()
                                    Spacer()
                                    Text("abc@gmail.com")
                                        .foregroundColor(.secondary)
                                        .frame(minWidth: 150)
                                }
                                HStack {
                                    Text("LinkedIn:")
                                        .bold()
                                    Spacer()
                                    Text("diljitPro@linkedIn")
                                        .foregroundColor(.secondary)
                                        .frame(minWidth: 150)
                                }
                            }
                        }
                        .modifier(GlassmorphicBackground())
                        .padding()
                        
                            //Rank, Birthday, Age
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Personal")
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                    .textCase(.uppercase)
                                    .padding(.bottom, 4)
                                
                                HStack(alignment: .top) {
                                    VStack {
                                        Text("2")
                                            .font(.system(size: 18, weight: .bold, design: .rounded))
                                            .bold()
                                        
                                        Text("Ranks")
                                            .font(.system(size: 12, weight: .regular, design: .rounded))
                                            .textCase(.uppercase)
                                        Spacer()
                                    }
                                    
                                    Spacer()
                                    
                                    VStack {
                                        Text("May 20")
                                            .font(.system(size: 18, weight: .bold, design: .rounded))
                                            .bold()
                                        
                                        Text("Birthday")
                                            .font(.system(size: 12, weight: .regular, design: .rounded))
                                            .bold()
                                            .textCase(.uppercase)
                                        Spacer()
                                    }
                                    
                                    Spacer()
                                    
                                    VStack {
                                        Text("34")
                                            .font(.system(size: 18, weight: .bold, design: .rounded))
                                            .bold()
                                        
                                        Text("Years Old")
                                            .font(.system(size: 12, weight: .regular, design: .rounded))
                                            .bold()
                                            .textCase(.uppercase)
                                        Spacer()
                                    }
                                }
                            }
                        }
                        .modifier(GlassmorphicBackground())
                        .padding([.horizontal, .bottom])
                        
                        
                            // Text messages, avg text, last communicated
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Communication")
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                    .textCase(.uppercase)
                                
                                Spacer()
                                
                                HStack {
                                    Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.")
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(2)
                                        .font(.system(size: 12, weight: .regular, design: .rounded))
                                    
                                    Spacer()
                                    
                                    Text("Yesterday")
                                        .font(.system(size: 12, weight: .regular, design: .rounded))
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                HStack {
                                    VStack {
                                        Text("4.3")
                                            .font(.system(size: 24, weight: .bold, design: .rounded))
                                        
                                        Text("Avg Texts / Day")
                                            .font(.system(size: 12, weight: .regular, design: .rounded))
                                            .textCase(.uppercase)
                                    }
                                    
                                    Spacer()
                                    
                                    VStack {
                                        Text("+19%")
                                            .font(.system(size: 24, weight: .bold, design: .rounded))
                                            .foregroundColor(.accentColor)
                                        
                                        Text("This month")
                                            .font(.system(size: 12, weight: .regular, design: .rounded))
                                            .textCase(.uppercase)
                                    }
                                    
                                    
                                    Spacer()
                                    
                                    VStack {
                                        Text("12 hrs")
                                            .font(.system(size: 24, weight: .bold, design: .rounded))
                                        
                                        Text("Last spoke")
                                            .font(.system(size: 12, weight: .regular, design: .rounded))
                                            .textCase(.uppercase)
                                    }
                                    
                                }
                            }
                            Spacer()
                        }
                        .modifier(GlassmorphicBackground())
                        .padding([.horizontal, .bottom])
                        
                            //Location and MAPS
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Location")
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                    .textCase(.uppercase)
                                
                                Spacer()
                                Text("Last seen at")
                                    .font(.system(size: 12, weight: .regular, design: .rounded))
                                
                                Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow))
                                    .frame(height: 300)
                                    .cornerRadius(12)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                                            .fill(.black.opacity(0.01))
                                    }
                            }
                            
                            Spacer()
                        }
                        .modifier(GlassmorphicBackground())
                        .padding([.horizontal, .bottom])
                        
                        Spacer()
                    }
                }
            }
            
            //Floating buttons
            VStack {
                Spacer()
                HStack {
                    Spacer()

                    ZStack {
                        Capsule()
                            .fill(.tint)
                            .frame(width: 160, height: 70)
                            .blur(radius: 8)
                        
                        Capsule()
                            .fill(.clear)
                            .frame(width: 160, height: 70)
                            .overlay {
                                HStack {
                                    Button {
                                        withAnimation {
                                            isBlurEnabled.toggle()
                                        }
                                    } label: {
                                        Image(systemName: "power.circle.fill")
                                            .foregroundColor(.white)
                                            .background(isBlurEnabled ? .green : .red)
                                            .font(.system(size: 40))
                                            .bold()
                                            .mask(Circle())
//                                            .rotationEffect(Angle(degrees: -90))
                                    }
                                    .padding(.leading)
                                    
                                    Spacer()
                                    
                                    Button {
                                        let phone = "tel://"
                                        let phoneNumberformatted = phone + phoneNumber
                                        guard let url = URL(string: phoneNumberformatted) else { return }
                                        UIApplication.shared.open(url)
                                    } label: {
                                        Image(systemName: "phone.circle.fill")
                                            .foregroundColor(.white)
                                            .font(.system(size: 42))
                                            .fontWeight(.thin)
                                    }
                                    .padding(.trailing)
                                }
                        }
                    }
                }
                .padding()
            }
            
        }
        .background {
            if isBlurEnabled {
                ZStack {
                    LinearGradient(colors: [Color.cyan.opacity(0.8), Color.purple.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    
                    Circle()
                        .fill(RadialGradient(colors: [Color.red.opacity(0.8), Color.orange.opacity(0.8)], center: UnitPoint(x: 0, y: 0), startRadius: 50, endRadius: 200))
                        .frame(width: 280)
                        .offset(x: -100, y: -150)
                        .blur(radius: 12)
                    
                    Circle()
                        .fill(RadialGradient(colors: [Color.blue.opacity(0.8), Color.pink.opacity(0.8)], center: UnitPoint(x: 0, y: 0), startRadius: 100, endRadius: 340))
                        .frame(width: 380)
                        .offset(x: 100, y: 100)
                        .blur(radius: 12)
                    
                    Rectangle()
                        .fill(LinearGradient(colors: [Color.green.opacity(0.8), Color.yellow.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 300, height: 300)
                        .cornerRadius(20)
                        .rotationEffect(Angle(degrees: 45))
                        .offset(x: -100, y: 300)
                        .blur(radius: 12)
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct ContactsDetails_Previews: PreviewProvider {
    static var previews: some View {
        ContactsDetails()
    }
}
