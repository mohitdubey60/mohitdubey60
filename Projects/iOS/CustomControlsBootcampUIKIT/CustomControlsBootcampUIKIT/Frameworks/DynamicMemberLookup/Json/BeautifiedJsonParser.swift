//
//  BeautifiedJsonParser.swift
//  CustomControlsBootcampUIKIT
//
//  Created by mohit.dubey on 13/07/23.
//

import Foundation

class BeautifiedJsonParser {
    func parseFakeProducts() {
        @FileWithUrl(fileNameWithExtension: "FakeProducts.json")
        var fileNameWithExtension: URL?
        
        if let fileUrl = fileNameWithExtension {
            do {
                let data = try Data(contentsOf: fileUrl)
                let json = try BeautifiedJson(data: data)
                
                print("Total product count \(String(describing: json.array?.count))")
                for product in json.array ?? [] {
                    print("- Product is \(String(describing: product.title))")
                }
            } catch let err {
                print("Error in reading file \(err.localizedDescription)")
            }
        }
    }
    
    func parseFakeWallet() {
        @FileWithUrl(fileNameWithExtension: "FakeWallet.json")
        var fileNameWithExtension: URL?
        
        if let fileUrl = fileNameWithExtension {
            do {
                let data = try Data(contentsOf: fileUrl)
                let json = try BeautifiedJson(data: data)
                
                print("______________Wallet________________)")
                print("Wallet is \(json.data.wallet_info.deeplink)")
                print("Wallet is \(json.data.jems_balance)")
                print("Second wallet option id is \(json.data.wallet_info.wallet_options[1].id)")
                for walletOption in json.data.wallet_info.wallet_options.array ?? [] {
                    print("- Value is \(String(describing: walletOption.id))")
                }
            } catch let err {
                print("Error in reading file \(err.localizedDescription)")
            }
        }
    }
}
