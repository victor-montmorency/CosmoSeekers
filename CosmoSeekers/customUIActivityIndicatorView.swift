//
//  customUIActivityIndicatorView.swift
//  CosmoSeekers
//
//  Created by victor mont-morency on 27/01/25.
//

import UIKit

class customUIActivityIndicatorView: UIActivityIndicatorView {
    var loadingIndicator = UIActivityIndicatorView()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showLoadingIndicator() {
        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.startAnimating()
    }
    func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
    }
}
