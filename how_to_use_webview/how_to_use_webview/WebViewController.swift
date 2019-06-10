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
        Alamofire.request( "https://learn.hanyang.ac.kr/learn/api/public/v1/courses/_9776_1/contents/_177603_1/children").responseJSON { response in
            debugPrint(response)
            
            if let json = response.result.value {
                print("JSON: \(json)")
            }
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
        frameSize=0
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
