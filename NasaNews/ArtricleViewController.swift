//
//  ArtricleViewController.swift
//  NasaNews
//
//  Created by Denisa Ionascu on 09.05.2022.
//

import UIKit
import WebKit

class ArtricleViewController: UIViewController{
    
    var item: Item?
    
    @IBOutlet var webVIew: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure(){
        guard let item = item else{
            return
        }
    
        title = item.title
        
        webVIew?.loadHTMLString(item.body, baseURL:nil)
    }
}
