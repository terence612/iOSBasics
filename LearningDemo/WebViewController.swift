//
//  WebViewController.swift
//  LearningDemo
//
//  Created by Terlun Leung on 6/11/2018.
//  Copyright © 2018 Terlun Leung. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class WebViewController: UIViewController {

    private var webView: WKWebView!
    private var contentController = WKUserContentController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
    }
    
    func setupViews() {
        self.view.backgroundColor = .white

        let webConfig = setupWebViewConfiguration()

        webView = WKWebView(frame: .zero,
                            configuration: webConfig)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.load(URLRequest(url: URL(string: "https://www.google.com.hk/")!))

        self.view.addSubview(webView)

        webView.snp.setLabel("webView")
        webView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin)
            } else {
                // Fallback on earlier versions
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
            }
        }
    }

    private func setupWebViewConfiguration() -> WKWebViewConfiguration {

        let webConfig = WKWebViewConfiguration()
        webConfig.userContentController = contentController
        return webConfig
    }

    func performSearch() {
        let injectSearchJs = """
        var field = document.getElementsByName("q")
        var form = document.getElementById("tsf")
        field[0].value = "Lady Gaga"
        """

        webView.evaluateJavaScript(injectSearchJs) { (result, error) in
            print("injectSearchJs", result, error)
        }

        //Delay for 5 second to perform next action
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            let injectSubmitJs = """
            form.submit()
            """
            self.webView.evaluateJavaScript(injectSubmitJs) { (result, error) in
                print("injectSubmitJs", result, error)
            }
        }
    }
}

// MARK: - WKNavigationDelegate
extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print(webView.url)

        if let currentUrl = webView.url?.absoluteString,
            currentUrl == "https://www.google.com.hk/" {
            performSearch()
        }
    }
}

// MARK: - WKUIDelegate
extension WebViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: "POPUP",
                                      message: message,
                                      preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .destructive) { (action) in
            completionHandler()
        }

        alert.addAction(okBtn)

        self.present(alert, animated: true, completion: nil)
    }

    //    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
    //        EGLog()
    //    }
    //
    //    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
    //        EGLog()
    //    }
}
