//
//  QRCodeGeneratorViewSwiftUI.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 04/08/23.
//

import SwiftUI

struct QRCodeGeneratorViewSwiftUI: View {
    @ObservedObject var vm: QRCodeGeneratorViewModel
    var body: some View {
        VStack {
            Text("QR Code generator")
                .font(.title)
                .padding(.bottom, 48)
            
            Spacer()
            TextField("Generate QR code for:", text: $vm.qrCodeText)
                .onChange(of: vm.qrCodeText, perform: { newValue in
                    withAnimation {
                        vm.qrImage = nil
                    }
                })
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 1)
                    .foregroundColor(.black.opacity(0.2))
            }
            .overlay {
                HStack {
                    Spacer()
                    Button {
                        vm.qrCodeText = "https://m.myjosh.in/6OaT/32e07bf"
                    } label: {
                        Image(systemName: "doc.on.clipboard")
                    }
                    .padding(6)
                    .overlay {
                        Circle()
                            .stroke(lineWidth: 2)
                    }
                    .foregroundColor(.black.opacity(0.4))

                }
                .padding()
            }
            
            Button {
                vm.generateQRCode(for: vm.qrCodeText)
            } label: {
                Text("Generate QR")
                    .padding(4)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)

            if let image = vm.qrImage {
                ZStack {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    Image("JoshLogo")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .overlay {
                            Circle()
                                .stroke(.white.opacity(0.2), lineWidth: 1)
                        }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                VStack {
                    Text("Generated QR image will appear here")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.gray.opacity(0.2))
                .mask {
                    RoundedRectangle(cornerRadius: 12)
                }
            }

            Spacer()
        }
        .padding()
    }
}

struct QRCodeGeneratorViewSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeGeneratorViewSwiftUI(vm: QRCodeGeneratorViewModel(manager:
                                                                    QRCodeManager(qrCodeService:
                                                                                    QRCodeOSService())))
    }
}
