//
//  APIClient.swift
//  CafeSearch
//
//  Created by 本田尚行 on 2020/09/17.
//  Copyright © 2020 本田尚行. All rights reserved.
//

import UIKit

class APIClient {

    func multipartPost(urlString: String, parameters: [String: Any]) {

        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"

        let (headers, body) = APIClient.createMultiPartPost(parameters: parameters)

        // ヘッダーの設定
        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }

        // Bodyの設定
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let response = response {
                print(response)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                    print(json)
                } catch {
                    print("parse error")
                }
            } else {
                print(error ?? "unknown error")
            }
        }

        // downloadTasl 実行例
        // let downtask = URLSession.shared.downloadTask(with: "https://"){
            
        //}
        task.resume()


    }

    static func createMultiPartPost(parameters: [String: Any]) -> (headers: [String:String], body: Data) {

        let uniqueId = UUID().uuidString
        let now = NSDate() // 現在日時の取得

        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US") as Locale // ロケールの設定
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss" // 日付フォーマットの設定
        
        let boundary = "---------------------------\(uniqueId)"

        let header = [
            "Content-Type" : "multipart/form-data; boundary=\(boundary)"
        ]

        var body = Data()

        let boundaryText = "--\(boundary)\r\n"


        for param in parameters {

            switch param.value {
            case let image as UIImage:

                let imageData = image.jpegData(compressionQuality: 1.0)!

                body.append(boundaryText.data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(param.key)\"; filename=\"\(uniqueId).jpg\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)

                body.append(imageData)
                body.append("\r\n".data(using: .utf8)!)

            case let string as String:

                body.append(boundaryText.data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(param.key)\";\r\n\r\n".data(using: .utf8)!)
                body.append(string.data(using: .utf8)!)
                body.append("\r\n".data(using: .utf8)!)

            case let value as Any:

                body.append(boundaryText.data(using: .utf8)!)

                // ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ここが問題↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
                body.append("Content-Disposition: form-data; name=\"\(param.key)\";\r\n\r\n".data(using: .utf8)!)
                body.append(String(describing: value).data(using: .utf8)!)
                body.append("\r\n".data(using: .utf8)!)

            default:
                break
            }
        }

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        return (header, body)
    }

}
