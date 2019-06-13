//
//  WebkitViewController.swift
//  UniAlarmee
//
//  Created by yuni on 10/06/2019.
//  Copyright © 2019 CSH. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
class WebkitViewController: UIViewController, WKUIDelegate, WKNavigationDelegate{
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBAction func getdata(_ sender: Any) {
        let url = URL(string: text)
        let request = URLRequest(url: url!)
        //print(request)
        Alamofire.request( "https://learn.hanyang.ac.kr/learn/api/public/v1/courses/_9776_1/contents/_177603_1/children").responseJSON { response in
            debugPrint(response)
            
            if let json = response.result.value {
                print("JSON: \(json)")
            }
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
        webView.load(request)
        
    }
    var text: String = "https://learn.hanyang.ac.kr/learn/api/public/v1/courses/_9776_1/contents/_177603_1/children"

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        let userScript = WKUserScript(source: "test()", injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let contentController = WKUserContentController()
        contentController.addUserScript(userScript)
        webConfiguration.userContentController = contentController
        super.loadView()
        webView = WKWebView(frame: self.view.frame)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        
        self.view = self.webView!
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myBlog = "http://learn.hanyang.ac.kr"
        let url = URL(string: myBlog)
        let request = URLRequest(url: url!)
        
        Alamofire.request( "https://learn.hanyang.ac.kr/learn/api/public/v1/oauth2/authorizationcode"
            ).responseJSON { response in
                debugPrint(response)
                
                if let json = response.result.value {
                    print("JSON: \(json)")
                }
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)") // original server data as UTF8 string
                }
                
        }
        Alamofire.request( "https://learn.hanyang.ac.kr/learn/api/public/v1/courses/_9776_1/contents/_177603_1/children"
            ).responseJSON { response in
                debugPrint(response)
                
                if let json = response.result.value {
                    print("JSON: \(json)")
                }
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)") // original server data as UTF8 string
                }
                
        }
        Alamofire.request( "https://learn.hanyang.ac.kr/learn/api/public/v1/courses/_9776_1/contents/_177603_1/children"
            ).responseJSON { response in
                debugPrint(response)
                
                if let json = response.result.value {
                    print("JSON: \(json)")
                }
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)") // original server data as UTF8 string
                }
                
        }
        webView.load(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title:nil, message: message, preferredStyle: .alert)
        let otherAction = UIAlertAction(title:"OK", style: .default, handler: {action in completionHandler()})
        alert.addAction(otherAction)
        
        self.present(alert, animated: true, completion: nil)
        //print(message.localizedUppercase)
    }
    
    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel, handler: {(action) in completionHandler(false)})
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {(action) in completionHandler(false)})
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        //print(message.localizedUppercase)
    }
    
    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        //activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.frame = CGRect(x:view.frame.midX-50, y: view.frame.midY-50, width: 100, height: 100)
        activityIndicator.color = UIColor.red
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        
    }
    
    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        var frame: CGRect = webView.frame
        frame.size.height = 700
        webView.frame = frame
        self.activityIndicator.removeFromSuperview()
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

