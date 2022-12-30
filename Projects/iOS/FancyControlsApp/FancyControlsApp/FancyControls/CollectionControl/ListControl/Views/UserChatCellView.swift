//
//  UserChatCell.swift
//  FancyControlsApp
//
//  Created by mohit.dubey on 24/11/22.
//

import SwiftUI

struct UserChatCellView: View {
    var item: Chat
    var body: some View {
        HStack {
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
            .padding(.trailing, 6)

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

struct UserChatCell_Previews: PreviewProvider {
    static var previews: some View {
        UserChatCellView(item: ChatsMock().chats[0])
    }
}
