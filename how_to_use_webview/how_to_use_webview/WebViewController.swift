//
//  WebViewController.swift
//  how_to_use_webview
//
//  Created by Choi Yechan on 03/06/2019.
//  Copyright © 2019 Choi Yechan. All rights reserved.
//

import UIKit
import Alamofire
class WebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    lazy var webView: UIWebView = {
        let webView = UIWebView()
        webView.delegate = self
        webView.frame = self.view.bounds
        let url: URL = URL(string: "https://learn.hanyang.ac.kr")!
        let request: NSURLRequest = NSURLRequest(url: url)
        webView.loadRequest(request as URLRequest)
        
        return webView
    }()
    
    var frameSize: CGFloat = 700.0
    var text: String = "https://learn.hanyang.ac.kr/learn/api/public/v1/courses/_9776_1/contents/_177603_1/children"
    @IBAction func Go(_ sender: Any) {
        let request: NSURLRequest = NSURLRequest(url: URL(string: text)!)
        webView.loadRequest(request as URLRequest)
    
        
        //how to get the userId
        var userID:String = "_30883_1"
        var updateManager:BlackboardManager = BlackboardManager.sharedInstance

        /*
        Alamofire.request( "https://learn.hanyang.ac.kr/ultra/institution-page/effective").responseString { response in
            //debugPrint(response)
            var html_String:String = response.result.value!
            print(html_String)
            
            userID = self.KMP(S: Array("/" + html_String), P: Array(String("/,\"id\":\"")), answerLength:8)
        }*/
        print("user id is \(userID)")
        
        
        //how to get the courseId
        /*
        Alamofire.request( "https://learn.hanyang.ac.kr/learn/api/public/v1/users/\(userID)/courses").responseJSON { response in
            //debugPrint(response)
            //var json_String:String = response.result.value!
            //print(json_String)
            if let result = response.result.value {
                let JSON = result as! NSDictionary
                print(JSON.count)
                print(JSON)
                let aa = JSON.object(forKey: "results") as! [NSDictionary]
                print(aa[0].object(forKey: "courseId"))
            }
        }
        */
        
        frameSize=0
    }
    func KMP(S:[Character], P:[Character], answerLength:Int) -> String{
        //set failureFunction
        var F:[Int] = Array(repeating: 0,count: 10)
        let pl:Int = P.count - 1
        let sl:Int = S.count - 1
        var j:Int = 0
        for now in 2...pl {
            while j != 0 && P[now] != P[j+1] {
                j = F[j]
            }
            if P[now] == P[j+1]{
                j = j+1
            }
            F[now] = j
        }
        //do kmp
        var i:Int = 0
        var cnt:Int = 0
        var answers:[Int] = []
        
        var answerID:[Character]=[]
        
        for now in 1...sl {
            while i != 0 && S[now] != P[i+1]{
                i = F[i]
            }
            if S[now] == P[i+1]{
                i = i+1
            }
            if i == pl {
                answers.append(now - pl + 1)
                cnt = cnt+1
                i = F[i]
            }
        }
        print(pl, answerLength)
        for idx in answers[0]+pl..<answers[0]+pl+answerLength {
            answerID.append(S[idx])
            print(S[idx], terminator: "")
        }
        return String(answerID)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.webView)

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        var frame: CGRect = webView.frame
        frame.size.height = frameSize
        webView.frame = frame
        print("webViewDidFinishLoad")
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("webViewDidStartLoad")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
