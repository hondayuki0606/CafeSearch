//
//  ViewController.swift
//  CafeSearch
//
//  Created by 本田尚行 on 2020/09/04.
//  Copyright © 2020 本田尚行. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var recieveImage: UIImageView!
    var postImage:UIImage?
    @IBOutlet weak var imageView: UIImageView!
    
    //URL to our web service
    //let URL_SAVE_BOY = "http://[Your ip Address]/MyWebService/api/createteam.php"
    
    let URL_SAVE_BOY = "https://ibop-asia.net/check/setagaya/input_do.php"
    var activityIndicatorView = UIActivityIndicatorView()
    //Button　action Method
    @IBOutlet weak var NameFeild: UITextField!
    @IBOutlet weak var oldFeild: UITextField!
    @IBOutlet weak var downloadBtn: UIButton!
    @IBAction func downloadBtn(_ sender: UIBarButtonItem) {
    
        print("test")
    }
   // UIBarButtonItem!
    
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBAction func saveBtn(_ sender: UIBarButtonItem) {
          
        let alertController = UIAlertController(title: "アップロード",message: "画像アップロード処理を実行してもよろしいでしょうか？", preferredStyle: UIAlertController.Style.alert)

        // OKボタンの実装
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            
            // OKがクリックされた時の処理
            let client = APIClient()
            let parameters:[String: Any]  = ["user_id": "hondayuki0606", "lat": 23.77, "lot": 99.222,
                                                 "comment": "コメント情報",
                                                 "hash_tag": "#カフェ","user_tag": "@hondayuki0606",
                                                 "image": self.imageView.image!]
            // インジケーターを表示＆アニメーション開始
            // 通信中インジケーター表示
            self.activityIndicatorView.center = self.view.center //画面中央に置く
            self.activityIndicatorView.style = .whiteLarge //スタイル設定。他に、gray,whiteが選べる
            self.activityIndicatorView.color = .gray //色設定
            self.view.addSubview(self.activityIndicatorView) //viewに追加する
            self.activityIndicatorView.startAnimating() //ローディング(くるくる)をまわす
            self.activityIndicatorView.hidesWhenStopped = true //ローディング止まった時、indicator消す(隠す)
            if self.activityIndicatorView.isAnimating { //ローディングしてるか確認
                print("ロード中")
            }
            // サーバー処理実施
            client.multipartPost(urlString: self.URL_SAVE_BOY, parameters: parameters)
            
            // インジケーターを非表示＆アニメーション終了
            self.activityIndicatorView.stopAnimating() //ローディング止める
            
 //           performSegue(withIdentifier: "goNext", sender: nil)
        }
 
        // CANCELボタンの実装
        let cancelButton = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: nil)
  
        // アップロードボタンの追加
        alertController.addAction(okAction)
        // CANCELボタンの追加
        alertController.addAction(cancelButton)
        // アラートの表示
        present(alertController,animated: true,completion: nil)
    
       // client.multipartPost(urlString: URL_SAVE_BOY, parameters: parameters)
//        //created NSURL
//          let requestURL = NSURL(string: URL_SAVE_BOY)
//          //creating NSMutableURLRequest
//          let request = NSMutableURLRequest(url: requestURL! as URL)
//          //setting the method to post
//          request.httpMethod = "POST"
//        
//        //テキストフィールドから値の取得
//        let user_id: String = "test_user"
//        let lat: Double = 49.1111
//        let lot: Double = 98.3234
//        let comment: String = "コメント情報"
//        let hash_tag: String = "#カフェ"
//        let user_tag: String = "@hondayuki"
//        //テキストフィールドからキーと値を連結してpostパラメータを生成する
//        let postParameters = "user_id=\(user_id)&lat=\(lat)&lot=\(lot)&comment=\(comment)&hash_tag=\(hash_tag)&user_tag=\(user_tag)"
//        //let postParameters = "address="+addressNo+"&sex="+sexNo!;
//
//      //  request.body.appendData(imageData!)
//        //ボディをリクエストするためのパラメータを追加する
//        request.httpBody = postParameters.data(using: String.Encoding.utf8)
//        //投稿要求を送信するタスクを作成する
//        let task = URLSession.shared.dataTask(with: request as URLRequest){
//        data, response, error in
//        if error != nil {
//        print("error is \(String(describing: error))")
//        return;
//        }
//        //返ってきたJsonの解析
//        do {
        //NSDictionaryに変換する
//         let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
//        //jsonデータの解析
//         if let parseJSON = myJSON {
//        //stringの生成
//         var msg : String!
//        //jsonからのレスポンスを取得
//         msg = parseJSON["message"] as! String?
//        //返ってきたものを表示
//         print(msg ?? "error")
//         }
//        }catch{
//         print(error)
//        }
//        }
//        task.resume()
       // self.performSegue(withIdentifier: "AfterVC", sender: nil)
    }

     
    // imageを選ぶボタン
    @IBOutlet weak var liblaryBtn: UIBarButtonItem!
    // カメラ撮影ボタン
    @IBAction func cameraBtn(_ sender: UIBarButtonItem) {
        let sourceType:UIImagePickerController.SourceType = UIImagePickerController.SourceType.camera

        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.imageView.image = image
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        self.dismiss(animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
