//
//  FetchRequest_TodoDetailsView.swift
//  AdvanceConcepts
//
//  Created by mohit.dubey on 22/12/22.
//

import SwiftUI
import UIKit

struct FetchRequest_TodoDetailsView: View {
    @State var titleText: String = ""
    @State var webImageUrl: String = ""
    @State var titleDescription: String = ""
    var colors: [Color] = TodoHelper.colors
    
    @ObservedObject var vm: TodoDetailViewModel
    
    private func taskCircle(_ color: Color) -> some View {
        return Circle()
            .fill(color)
            .frame(width: 44, height: 44)
            .overlay {
                if let colorString = vm.todoItem.color, Color(hex: colorString) == color {
                    Circle()
                        .strokeBorder(Color(uiColor: UIColor.secondaryLabel), lineWidth: 4)
                }
            }
            .onTapGesture {
                withAnimation {
                    vm.todoItem.color = color.toHex
                }
            }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                TextField("Enter notes title here", text: $vm.todoItem.title.toUnwrapped(defaultValue: ""))
                    .padding(.leading)
                    .frame(height: 60)
                    .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top)
                
                TextField("Enter notes description here", text: $vm.todoItem.todoDescription.toUnwrapped(defaultValue: ""))
                    .multilineTextAlignment(.leading)
                    .lineLimit(0)
                    .padding(.leading)
                    .frame(height: 200)
                    .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top)
                    
                Group {
                    VStack(alignment: .leading) {
                        if webImageUrl.trimmingCharacters(in: .whitespaces) != "" {
                            Image(systemName: "gear")
                                .resizable()
                                .scaledToFit()
                                .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                                .frame(height: 240)
                                .cornerRadius(10)
                                .clipped()
                        }
                        TextField("Enter image url here", text: $webImageUrl)
                            .padding(.leading)
                            .frame(height: 60)
                            .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                            .cornerRadius(10)
                        Button {
                            
                        } label: {
                            Text("Select image")
                                .font(.headline)
                                .frame(width: 200, height: 30)
                                .foregroundColor(.white)
                                .padding()
                                .background(.tint)
                                .cornerRadius(10)
                                
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                }
                
                VStack(alignment: .leading) {
                    Text("Label your task")
                        .font(.headline)
                    HStack {
                        ForEach(colors, id: \.self) { color in
                            taskCircle(color)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top)
            }
        }
        .onDisappear {
            
        }
        .navigationTitle("Add/Edit Notes")
    }
}

struct FetchRequest_TodoDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        FetchRequest_TodoDetailsView(vm: TodoDetailViewModel(item:
                                                                TodoEntity(context: PersistenceController.shared.container.viewContext)
                                                            ))
    }
}
