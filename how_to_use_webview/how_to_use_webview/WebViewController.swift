//
//  WebViewController.swift
//  how_to_use_webview
//
//  Created by Choi Yechan on 03/06/2019.
//  Copyright © 2019 Choi Yechan. All rights reserved.
//

import UIKit

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
    
    var text: String = "https://learn.hanyang.ac.kr/learn/api/public/v1/courses/_9776_1/contents/_177603_1/children"
    @IBAction func Go(_ sender: Any) {
        let request: NSURLRequest = NSURLRequest(url: URL(string: text)!)
        webView.loadRequest(request as URLRequest)
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
        frame.size.height = 700
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
