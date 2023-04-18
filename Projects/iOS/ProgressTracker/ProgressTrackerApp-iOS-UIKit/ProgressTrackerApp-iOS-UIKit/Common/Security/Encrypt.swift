////
////  Encrypt.swift
////  ProgressTrackerApp-iOS-UIKit
////
////  Created by mohit.dubey on 12/02/23.
////
//
//import Foundation
//import CryptoKit
//import CryptoTokenKit
//import SwiftyRSA
//
//fileprivate class AESEncryption {
//    enum AESError: Error {
//        case KeyError((String, Int))
//        case IVError((String, Int))
//        case CryptorError((String, Int))
//    }
//    
//    func generateKey(key aesKey: String) -> Data? {
//        if let data = aesKey.data(using: .utf8)?.prefix(16) {
//            return data
//        }
//        
//        return nil
//    }
//    
//    func convertStringToData(encrypt stringToEncrypt: String) -> Data? {
//        if let data = stringToEncrypt.data(using: .utf8) {
//            return data
//        }
//        
//        return nil
//    }
//    
//        // The iv is prefixed to the encrypted data
//    func aesCBCEncrypt(data:Data, keyData:Data) throws -> Data {
//        let keyLength = keyData.count
//        let validKeyLengths = [kCCKeySizeAES128, kCCKeySizeAES192, kCCKeySizeAES256]
//        if (validKeyLengths.contains(keyLength) == false) {
//            throw AESError.KeyError(("Invalid key length", keyLength))
//        }
//        
//        let ivSize = kCCBlockSizeAES128;
//        let cryptLength = size_t(ivSize + data.count + kCCBlockSizeAES128)
//        var cryptData = Data(count:cryptLength)
//        
//        let status = cryptData.withUnsafeMutableBytes {ivBytes in
//            SecRandomCopyBytes(kSecRandomDefault, kCCBlockSizeAES128, ivBytes)
//        }
//        if (status != 0) {
//            throw AESError.IVError(("IV generation failed", Int(status)))
//        }
//        
//        var numBytesEncrypted :size_t = 0
//        let options   = CCOptions(kCCOptionPKCS7Padding)
//        
//        let cryptStatus = cryptData.withUnsafeMutableBytes {cryptBytes in
//            data.withUnsafeBytes {dataBytes in
//                keyData.withUnsafeBytes {keyBytes in
//                    CCCrypt(CCOperation(kCCEncrypt),
//                            CCAlgorithm(kCCAlgorithmAES),
//                            options,
//                            keyBytes, keyLength,
//                            cryptBytes,
//                            dataBytes, data.count,
//                            cryptBytes+kCCBlockSizeAES128, cryptLength,
//                            &numBytesEncrypted)
//                }
//            }
//        }
//        
//        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
//            cryptData.count = numBytesEncrypted + ivSize
//        }
//        else {
//            throw AESError.CryptorError(("Encryption failed", Int(cryptStatus)))
//        }
//        
//        return cryptData;
//    }
//    
//        // The iv is prefixed to the encrypted data
//    func aesCBCDecrypt(data:Data, keyData:Data) throws -> Data? {
//        let keyLength = keyData.count
//        let validKeyLengths = [kCCKeySizeAES128, kCCKeySizeAES192, kCCKeySizeAES256]
//        if (validKeyLengths.contains(keyLength) == false) {
//            throw AESError.KeyError(("Invalid key length", keyLength))
//        }
//        
//        let ivSize = kCCBlockSizeAES128;
//        let clearLength = size_t(data.count - ivSize)
//        var clearData = Data(count:clearLength)
//        
//        var numBytesDecrypted :size_t = 0
//        let options   = CCOptions(kCCOptionPKCS7Padding)
//        
//        let cryptStatus = clearData.withUnsafeMutableBytes {cryptBytes in
//            data.withUnsafeBytes {dataBytes in
//                keyData.withUnsafeBytes {keyBytes in
//                    CCCrypt(CCOperation(kCCDecrypt),
//                            CCAlgorithm(kCCAlgorithmAES128),
//                            options,
//                            keyBytes, keyLength,
//                            dataBytes,
//                            dataBytes+kCCBlockSizeAES128, clearLength,
//                            cryptBytes, clearLength,
//                            &numBytesDecrypted)
//                }
//            }
//        }
//        
//        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
//            clearData.count = numBytesDecrypted
//        }
//        else {
//            throw AESError.CryptorError(("Decryption failed", Int(cryptStatus)))
//        }
//        
//        return clearData;
//    }
//}
//
//fileprivate class RSAEncryption {
//    fileprivate let rsaPublicKey: String
//    fileprivate let rsaPrivateKey: String
//    
//    init(rsaPublicKey: String, rsaPrivateKey: String) {
//        self.rsaPublicKey = rsaPublicKey
//        self.rsaPrivateKey = rsaPrivateKey
//    }
//    
//    func encrypt(string: String, publicKey: String?) -> String? {
//        guard let publicKey = publicKey else { return nil }
//        
//        let keyString = publicKey
//            .replacingOccurrences(of: "-----BEGIN RSA PUBLIC KEY-----\n", with: "")
//            .replacingOccurrences(of: "\n-----END RSA PUBLIC KEY-----", with: "")
//            .replacingOccurrences(of: "\n-----END RSA PUBLIC KEY-----", with: "")
//            .replacingOccurrences(of: "\n-----END RSA PUBLIC KEY-----", with: "")
//        guard let data = Data(base64Encoded: keyString, options: .ignoreUnknownCharacters) else { return nil }
//        
//        var attributes: CFDictionary {
//            return [kSecAttrKeyType         : kSecAttrKeyTypeRSA,
//                    kSecAttrKeyClass        : kSecAttrKeyClassPublic,
//                    kSecAttrKeySizeInBits   : 2098,
//                    kSecReturnPersistentRef : true] as CFDictionary
//        }
//        Swift.print("Mohit: Key buffer size \(data) \(attributes)")
//        var error: Unmanaged<CFError>? = nil
//        guard let secKey = SecKeyCreateWithData(data as CFData, attributes, &error) else {
//            print(error.debugDescription)
//            return nil
//        }
//        return encrypt(string: string, publicKey: secKey)
//    }
//    
//    func encrypt(string: String, publicKey: SecKey) -> String? {
//        let buffer = [UInt8](string.utf8)
//        
//        var keySize   = SecKeyGetBlockSize(publicKey)
//        var keyBuffer = [UInt8](repeating: 0, count: keySize)
//        Swift.print("Mohit: Key buffer size \(keySize) \(keyBuffer)")
//            // Encrypto  should less than key length
//        guard SecKeyEncrypt(publicKey, SecPadding.PKCS1, buffer, buffer.count, &keyBuffer, &keySize) == errSecSuccess else { return nil }
//        return Data(bytes: keyBuffer, count: keySize).base64EncodedString()
//    }
//}
//
//class EncryptBL {
//    let stringToEncrypt = "{\"id\":1,\"name\":\"sharad\",code:\"ashish\"}"
//    var aesKey = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
//    fileprivate let aesObj = AESEncryption()
//    //Sample base64 string: "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDVGUzbydMZS+fnkGTsUkDKEyFOGwghR234d5GjPnMIC0RFtXtw2tdcNM8I9Qk+h6fnPHiA7r27iHBfdxTP3oegQJWpbY2RMwSmOs02eQqpKx4QtIjWqkKk2Gmck5cll9GCoI8AUAA5e0D02T0ZgINDmo5yGPhGAAmqYrm8YiupwQIDAQAB"
//    fileprivate let rsaObj = RSAEncryption(rsaPublicKey: "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlHZk1BMEdDU3FHU0liM0RRRUJBUVVBQTRHTkFEQ0JpUUtCZ1FDWkd2L1dncXo1OEhjOURMZUFObHRmNFVJMwp3Vkoyb0xJYzZEemRheFdaTXRSVkYzTGYySlFSZURQMTRsKzNYUGdXaC9lVlFBU1Z3QTZKaUYxemw1WXhJS1ovCmppc2NEaFRDS25idmE1dTdrYjFMb0FUTlFKQlZtZGhSOFVZbWc3dUZWMnJTVUg3UEJ3VytyLzhKcm9sOXA1SGEKckIxVlBPMEtIR0YyZ2JNS2V3SURBUUFCCi0tLS0tRU5EIFBVQkxJQyBLRVktLS0tLQo=", rsaPrivateKey: "LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlDV3dJQkFBS0JnUUNaR3YvV2dxejU4SGM5RExlQU5sdGY0VUkzd1ZKMm9MSWM2RHpkYXhXWk10UlZGM0xmCjJKUVJlRFAxNGwrM1hQZ1doL2VWUUFTVndBNkppRjF6bDVZeElLWi9qaXNjRGhUQ0tuYnZhNXU3a2IxTG9BVE4KUUpCVm1kaFI4VVltZzd1RlYyclNVSDdQQndXK3IvOEpyb2w5cDVIYXJCMVZQTzBLSEdGMmdiTUtld0lEQVFBQgpBb0dBR1YrRkdKcXRhZnAwK0ZRY01RNVJGRkd6ZEtRQU01S3NFZWhXOWViaVBISlZDQWtMeTVjTDZ0MDkxemo5CjNkaDFjTjUxcEhGb2tSeTBEQXppVjk2K1VBSlRMcEJlVmIyVG5WbHlGZTBoYXpaTkJnV1JkTkUrVytjUkpQS2kKNmZqbVFXVmhReUlFZEIrdnVpdUJ4MjYzTU4zbFBXMWc0WDFDcGkvM3pIOGJrV2tDUVFES2lFaGd5U0YvY013dAp1L3BSRW0xNWpsT0h2dWhiTzFjMEQvTi9xU3VTVE5NZmN5SVE1SXoraTRBRnNxSFNYTjB6Qkl6OVBRUjlvemxyCjJLS1huakV0QWtFQXdZWk9TWHN5V2M5NVVpL2IxTFpSR0RPVTB6OUMveU03bWE4WjFjU1FnTFpxR2V4UXUrQmEKZnY1dWxDU3cwcWtpNnBkRUpXRyttempiZm5LRTRtdGpSd0pBR1VLeU5GQWh1M0ZvSmZRaUhtWjcvUU5CYTlibAp5Q3M0anlmR0tSQUNmVGJUeGtKbjUwOTZQbTFMeEdvcFFNR1FYVUtlQ3gvSEpaeHNGd1ZvRWgwSzZRSkFFSE5kClJrdk5yT3JCRW1aMUZuRGxGZHlVb3h4MmtuK3BPbGd6SndQTmtOTncwNEZPSDVwanR2WGo2bjN2OWdoZ3FuWnYKV1lva2pNZFppVGNzNnA1Y1V3SkFXVHJvZnhHNFBydWwzVXRENnV1OWkydW0vWm1CSnVFd2lscnM5Z3BlRkIvZAp1a2taM0Urdzkxc0pPbnZrWWg3aDF2UXF1bGlQNlcwOFFVbTA0RWR2ekE9PQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQo=")
//}
//
//extension EncryptBL {
//    func printAESKey() {
//        var aesEnc = ""
//        var rsaEnc = ""
//        
//        if let key = aesObj.generateKey(key: aesKey), let data = aesObj.convertStringToData(encrypt: stringToEncrypt) {
//            do {
//                let encryptedData = try aesObj.aesCBCEncrypt(data: data, keyData: key)
//                Swift.print("Mohit: Encrytped data is \(encryptedData)")
//                Swift.print("Mohit: Base64 encryptedValue is \(encryptedData.base64EncodedString())")
//                aesEnc = encryptedData.base64EncodedString()
//                if let decryptedData = try aesObj.aesCBCDecrypt(data: encryptedData, keyData: key), let stringValue = String(data: decryptedData, encoding: .utf8) {
//                    Swift.print("Mohit: Decrypted value is \(stringValue)")
//                }
//                
//            } catch let err {
//                Swift.print("Mohit: Error in encrypting \(err.localizedDescription)")
//            }
//        }
//        
//        do {
//            if let utf8PublicKey = rsaObj.rsaPublicKey.fromBase64(), let utf8PrivateKey = rsaObj.rsaPrivateKey.fromBase64() {
//                
//                let publicKey = try PublicKey(pemEncoded: utf8PublicKey)
//                let clear = try ClearMessage(string: aesKey, using: .utf8)
//                let encryptedData = try clear.encrypted(with: publicKey, padding: .PKCS1)
//                let result = encryptedData.data.base64EncodedString()
//                Swift.print("Mohit: Encrypted RSA data is \(result)")
//                rsaEnc = result
//                
//                let privateKey = try PrivateKey(pemEncoded: utf8PrivateKey)
//                let encrypted = try EncryptedMessage(base64Encoded: result)
//                let clearD = try encrypted.decrypted(with: privateKey, padding: .PKCS1)
//                
//                let data = clearD.data
//                let base64String = clearD.base64String
//                let string = try clearD.string(encoding: .utf8)
//                Swift.print("Mohit: Result is \(string)")
//            }
//            
//            Swift.print(aesEnc + "|" + rsaEnc + "|" + "1")
//            
//        } catch let err {
//            Swift.print("Mohit: RSA public key error \(err.localizedDescription)")
//        }
//    }
//}
