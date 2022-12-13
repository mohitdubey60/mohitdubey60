    //
    //  WelcomeView.swift
    //  FancyControlsApp
    //
    //  Created by mohit.dubey on 10/12/22.
    //

import SwiftUI

struct WelcomeView: View {
    @AppStorage("userList") var userList: TodoAppUserList = []
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    
    @State var isAlertPresented = false
    
    @State var ctaText = "Next"
    
    @State var currentScreenCount = 0
    @State var currentPage: CurrentPage = .welcome
    
    @State var userName: String = ""
    @State var userAge: String = ""
    
    enum CurrentPage: Int {
        case welcome = 0
        case userDetails = 1
        case finish = 2
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                switch currentPage {
                    case .welcome:
                        welcomeView
                            .transition(transition)
                    case .userDetails:
                        userDataView
                            .transition(transition)
                    case .finish:
                        finishView
                            .transition(transition)
                }
                Spacer()
            }
            .padding()
            .alert(isPresented: $isAlertPresented) {
                Alert(title: Text("Invalid user details"), message: Text("Either username or age is invalid"))
            }
            
            
            Spacer()
            
            Text(ctaText)
                .font(.title2)
                .foregroundColor(.purple)
                .padding()
                .frame(height: 70)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(10)
                .padding()
                .shadow(radius: 10)
                .onTapGesture {
                    if currentScreenCount < 3 {
                        withAnimation {
                            moveToNextScreen()
                        }
                    }
                }
        }
        .background {
            RadialGradient(colors: [Color.purple, Color.blue], center: .topLeading, startRadius: 100, endRadius: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
        }
        .navigationTitle("Welcome")
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}


extension WelcomeView {
    private var welcomeView: some View {
        VStack(alignment: .center, spacing: 20.0) {
            Image(systemName: "heart.text.square")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                .font(.callout)
            
        }
        .foregroundColor(.white)
    }
    
    private var userDataView: some View {
        VStack(spacing: 20.0) {
            TextField("User name goes here...", text: $userName)
                .frame(height: 70)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .foregroundColor(Color.black)
                .cornerRadius(10)
            
            TextField("Age goes here", text: $userAge)
                .keyboardType(.numberPad)
                .frame(height: 70)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .foregroundColor(Color.black)
                .cornerRadius(10)
        }
    }
    
    private var finishView: some View {
        VStack(spacing: 20.0) {
            Image(systemName: "hourglass.tophalf.filled")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                .font(.callout)
        }
        .foregroundColor(.white)
    }
}

extension WelcomeView {
    private func moveToNextScreen() {
        if currentPage == .userDetails && !isValidUserDetails() {
            isAlertPresented = true
            return
        }
        
        currentScreenCount += 1
        if currentScreenCount == 3 {
            userList.append(TodoAppUser(name: userName, age: Int(userAge) ?? 0))
            return
        }
        
        currentPage = CurrentPage(rawValue: currentScreenCount) ?? .welcome
        
        if currentScreenCount == 2 {
            ctaText = "Finish"
        } else {
            ctaText = "Next"
        }
    }
    
    private func isValidUserDetails() -> Bool {
        if userName.count > 3 && (Int(userAge) ?? 0 > 18 && Int(userAge) ?? 0 < 100) {
            return true
        }
        
        return false
    }
}
