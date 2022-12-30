    //
    //  TodoAppUserListView.swift
    //  FancyControlsApp
    //
    //  Created by mohit.dubey on 12/12/22.
    //

import SwiftUI

struct TodoAppUserListView: View {
    @AppStorage("userList") var userList: TodoAppUserList = []
    @State var isSettingsPagePresented = false
    @State var isInfoSheetPresented = false
    
    var body: some View {
        VStack {
            List {
                ForEach(userList, id: \.name) { user in
                    Text(user.name)
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                }
                .onDelete(perform: delete)
                .listRowBackground(Color(uiColor: UIColor.clear))
            }
            .listStyle(.plain)
            
            NavigationLink(destination: WelcomeView()) {
                Text("Create New Profile")
                    .font(.title2)
                    .foregroundColor(.purple)
                    .padding()
                    .frame(height: 70)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding()
                    .shadow(radius: 10)
            }
            
        }
        .background {
            RadialGradient(colors: [Color.purple, Color.blue], center: .topLeading, startRadius: 100, endRadius: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
        }
        .navigationTitle("User List")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    isSettingsPagePresented.toggle()
                } label: {
                    Image(systemName: "gear")
                }
                .foregroundColor(.white)
                
                Button {
                    isInfoSheetPresented.toggle()
                } label: {
                    Image(systemName: "info.circle")
                }
                .foregroundColor(.white)
            }
        }
        .sheet(isPresented: $isSettingsPagePresented) {
            TodoAppSettingsView()
        }
        .actionSheet(isPresented: $isInfoSheetPresented) {
            ActionSheet(title: Text("Information sheet"), buttons: [
                .default(Text("Info"), action: {
                    //Infor button click action goes here
                }),
                .cancel(
                    Text("Cancel")
                    .foregroundColor(.red), action: {
                    //cancel button click action goes here
                })
            ])
        }
        
    }
    
    func delete(at offsets: IndexSet) {
        userList.remove(atOffsets: offsets)
    }
}

struct TodoAppUserListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoAppUserListView()
    }
}
