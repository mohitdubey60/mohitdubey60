    //
    //  CustomWebViewController.swift
    //  CustomControlsBootcampUIKIT
    //
    //  Created by mohit.dubey on 21/06/23.
    //

import UIKit
import WebKit
import SwiftUI

class CustomWebViewController: UIViewController {
    private let webView: WKWebView
    private let configuration: WKWebViewConfiguration
    private var externalLinks: [String]
    private let navigationHandler: CustomWebViewNavigationHandler
    
    private var showProgress: Bool
    private var progressBar: UIProgressView
    private var webNavigationView: WebViewNavBarView?
    private var showNavigation: Bool
    private var progressBarHeightConstraint: NSLayoutConstraint?
    
    private let imageSaver: ImageSaver = ImageSaver()
    
    init(configuration: WKWebViewConfiguration, showProgress: Bool = true, externalLinks: [String] = ["tel://"], showNavigation: Bool = true) {
        self.webView = WKWebView(frame: .zero, configuration: configuration)
        self.configuration = configuration
        self.externalLinks = externalLinks
        
        navigationHandler = CustomWebViewNavigationHandler(externalHostLinks: externalLinks)
        navigationHandler.webView = webView
        
        self.showProgress = showProgress
        self.progressBar = UIProgressView(frame: .zero)
        
        self.showNavigation = showNavigation
        
        super.init(nibName: nil, bundle: nil)
        
        navigationHandler.delegate = self
        self.webView.navigationDelegate = navigationHandler
        
        self.webView.addObserver(navigationHandler, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        if showProgress {
            view.addSubview(progressBar)
            setupProgressView()
        }
        
        if showNavigation,
           let navigationView = UINib(nibName: "WebViewNavBarView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? WebViewNavBarView {
            navigationView.delegate = self
            webNavigationView = navigationView
            view.addSubview(navigationView)
            setupNavigation(navigationView)
        }
        
        view.addSubview(webView)
        setupWebView()
        
        
        let urlString = "https://www.verse.in/"//"https://www.kodeco.com/5456-in-app-purchase-tutorial-getting-started" //"tel://+919611886748"
        if let url = URL(string: urlString) {
            navigateToUrl(url: url)
        }
    }
    
    func navigateToUrl(url: URL) {
        DispatchQueue.main.async {
            let urlRequest = URLRequest(url: url)
            self.webView.load(urlRequest)
        }
    }
}

extension CustomWebViewController {
    private func setupWebView() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        let guide = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            webView.topAnchor.constraint(equalTo: showNavigation && webNavigationView != nil ? webNavigationView!.bottomAnchor : guide.topAnchor)
        ])
        if #available(iOS 16.4, *) {
            webView.isInspectable = true
        }
        webView.customUserAgent = "CustomcontrolBootCamp"
        
        let messageHandler = CustomWebViewMessageHandler(delegate: self)
        JSFunctionNames.listOfReceiveJSFunctions.forEach({ webView.configuration.userContentController.add(messageHandler, name: $0.key) })
    }
    
    func setupProgressView() {
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.progressTintColor = .cyan
        progressBar.trackTintColor = .red
        progressBar.setProgress(0, animated: true)
        let guide = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: guide.topAnchor),
            progressBar.leftAnchor.constraint(equalTo: guide.leftAnchor),
            progressBar.rightAnchor.constraint(equalTo: guide.rightAnchor)
        ])
    }
    
    func setupNavigation(_ navigationView: WebViewNavBarView) {
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        let guide = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: showProgress ? progressBar.bottomAnchor : guide.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
}

extension CustomWebViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        didReceiveMessage(message: message)
    }
    
    func didReceiveMessage(message: WKScriptMessage) {
        if let data = message.body as? [Any] {
            print(message.name)
            data.forEach({ print($0) })
        }
    }
}

extension CustomWebViewController: WebViewNavigationHandler {
    
    func navigationCancelled() {
        
    }
    
    func navigationCompleted() {
        getWebViewCookies()
    }
    
    private func changeProgressViewVisibility(_ percentage: Double) {
        if percentage < 1, self.showProgress {
            self.progressBar.alpha = 1
            self.progressBar.isHidden = false
            progressBar.heightAnchor.constraint(equalToConstant: 1).isActive = true
        } else {
            UIView.animate(withDuration: 0.5) {
                self.progressBar.alpha = 0
                self.progressBar.heightAnchor.constraint(equalToConstant: 0).isActive = true
            } completion: { completed in
                print(completed)
                self.progressBar.isHidden = true
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func pageLoad(percentage: Double) {
        DispatchQueue.main.async {
            self.changeProgressViewVisibility(percentage)
            self.progressBar.setProgress(Float(percentage), animated: true)
        }
    }
    
    func navigatingTo(page currentPage: String) {
        webNavigationView?.update(currentPageNavigationTitle: currentPage)
    }
    
    func aboutBlankNavigationRequested() {
        
    }
}

extension CustomWebViewController: WebNavbarActions {
    func reloadWebPage() {
        webView.reload()
    }
    
    func navigateBack() {
    
    }
    
    func navigateForward() {
        
    }
    
    func takeSnapshot() {
        let config = WKSnapshotConfiguration()
        //webView.scrollView.contentSize.width
        config.rect = CGRect(origin: .zero, size: UIScreen.main.bounds.size)//CGRect(origin: .zero, size: webView.scrollView.contentSize)
        webView.takeSnapshot(with: config) {[weak self] image, error in
            guard let image else {
                if let error {
                    print(error.localizedDescription)
                    
                }
                return
            }
            
            self?.imageSaver.writeToPhotoAlbum(image: image)
        }
    }
}

extension CustomWebViewController {
    func getWebViewCookies() {
        webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
            for cookie in cookies {
                print("\(cookie.name) is set to \(cookie.value)")
                    //                if cookie.name == "authentication" {
                    //                    self.webView.configuration.websiteDataStore.httpCookieStore.delete(cookie)
                    //                } else {
                    //                    print("\(cookie.name) is set to \(cookie.value)")
                    //                }
            }
        }
    }
}

fileprivate class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        print("Write image is called \(image.size)")
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error {
            print("Error is \(error.localizedDescription)")
            return
        }
        print("Save finished!")
    }
}

//struct CustomWebViewControllerRepresentable: UIViewControllerRepresentable {
//    func updateUIViewController(_ uiViewController: CustomWebViewController, context: Context) {
//        
//    }
//    
//    typealias UIViewControllerType = CustomWebViewController
//    
//    func makeUIViewController(context: Context) -> CustomWebViewController {
//        let controller = CustomWebViewController(configuration: CustomWebViewConfiguration(context: "customActionObject").getConfiguration())
//        return controller
//    }
//}
//
//struct CustomWebViewController_Previews: PreviewProvider {
//    static let devices: [String] = ["iPhone SE",
//                                    "iPhone 11 Pro Max",
//                                    "iPad Pro (11-inch)",
//                                    "Apple Watch Series 5"]
//    static var previews: some View {
//        Group {
//            ForEach(CustomWebViewController_Previews.devices, id: \.self) { device in
//                CustomWebViewControllerRepresentable()
//                    .previewDevice(PreviewDevice(rawValue: device))
//                    .previewDisplayName(device)
//            }
//        }
//    }
//}
