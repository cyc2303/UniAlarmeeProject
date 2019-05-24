//
//  APIViewController.swift
//  UniAlarmee
//
//  Created by yuni on 24/05/2019.
//  Copyright © 2019 CSH. All rights reserved.
//

import UIKit

class APIViewController: UIViewController {
    @IBOutlet weak var test: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let manager: OAuthInfoManager = OAuthInfoManager.sharedInstance() as! OAuthInfoManager
        manager.clientId = "557fa82c9492fe2527744c944670e55f"
        manager.clientSecret = "21a5252251b209d20ee0568b29cce1"
        manager.scope = "35"
        manager.login()
        manager.saveOAuthInfo()
        let token = manager.oAuthInfo.accessToken
        let api:APIRequest = APIRequest.init()
        let req_url: NSString = "https://learn.hanyang.ac.kr/learn/api/public/v1/courses/_9776_1/contents/_177603_1/children"
        let param: NSMutableDictionary = NSMutableDictionary.init()
        param.setValue(_ : "test", forKey: "한양과제알리미")
        let req: RequestBundle = RequestBundle.init()
        req.url = String(req_url)
        req.parameters = param as! [AnyHashable : Any]
        req.httpMethod = eSmartHttpMethod.GET
        req.responseType = eSmartContentType.JSON

        let error: NSError? = nil;
        
        do{
            let resp :ResponseMessage = try api.request(req)
                test.text = resp.resultMessage
                print(resp.resultMessage)
        }
        catch{
            print(error.localizedDescription)
        }
        
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
