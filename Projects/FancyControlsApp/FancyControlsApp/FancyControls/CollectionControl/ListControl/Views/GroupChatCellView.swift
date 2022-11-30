//
//  GroupChatCellView.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 24/11/22.
//

import SwiftUI

struct GroupChatCellView: View {
    var item: Chat
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                AsyncImage(url: URL(string: item.imagePath)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .aspectRatio(contentMode: .fill)
                }
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                .padding(.leading, 6)
                
                AsyncImage(url: URL(string: item.imagePath)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .aspectRatio(contentMode: .fill)
                }
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .overlay(Circle()
                    .stroke(Color.gray, lineWidth: 2))
            }
                        
            VStack (alignment: .leading) {
                Text(item.title)
                    .font(.title3)
                Spacer()
                Text(item.description)
                    .multilineTextAlignment(.leading)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.vertical)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 70)
    }
}

struct GroupChatCellView_Previews: PreviewProvider {
    static var previews: some View {
        GroupChatCellView(item: ChatsMock().chats.first!)
    }
}
