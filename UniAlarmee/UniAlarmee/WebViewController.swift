//
//  WebViewController.swift
//  UniAlarmee
//
//  Created by Choi Yechan on 13/06/2019.
//  Copyright © 2019 CSH. All rights reserved.
//

import UIKit
import Alamofire
class WebViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var hakbun:String = ""
    
    lazy var webView: UIWebView = {
        let webView = UIWebView()
        webView.delegate = self
        webView.frame = self.view.bounds
        let url: URL = URL(string: "https://learn.hanyang.ac.kr")!
        let request: NSURLRequest = NSURLRequest(url: url)
        webView.loadRequest(request as URLRequest)
        
        return webView
    }()
    
    var frameSize: CGFloat = 2000.0
    var text: String = "https://learn.hanyang.ac.kr/learn/api/public/v1/courses/_9776_1/contents/_177603_1/children"
    func Go(_ sender: Any) {
        /*
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
 */
        //dismiss(animated: false, completion: nil)
        //self.navigationController?.popViewController(animated: false)
        //frameSize=0.0
        //dismiss(animated: false, completion: nil)
        var myboard:BlackboardManager = BlackboardManager.sharedInstance
        myboard.RenewUserId()
        hakbun = myboard.userId
        print("###################################학번:"+hakbun)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(5)){
            //5초 기다린 후에 화면이 전환 됨
            self.performSegue(withIdentifier: "exit", sender: nil)
        }
        
        //self.navigationController?.popViewController(animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! SettingViewController
        dest.loginID = hakbun
    }
    
    var didLogin = false
    override func viewDidLoad() {
        super.viewDidLoad()
        if didLogin==false {
            self.view.addSubview(self.webView)
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        var frame: CGRect = webView.frame
        frame.size.height = frameSize
        //frame.origin.x = 240
        webView.frame = frame
        while (webView.isLoading){
            Go(WebViewController())
            //frameSize = 0.0
            //frame.size.height = frameSize
            //webView.frame = frame
            //didLogin = true
            //dismiss(animated: false, completion: nil)
            //self.navigationController?.popViewController(animated: false)
            break
        }
        didLogin = true
        print("webViewDidFinishLoad")
        //Go(WebViewController())
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
