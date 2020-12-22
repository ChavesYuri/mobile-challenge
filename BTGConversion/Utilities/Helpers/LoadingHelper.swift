//
//  LoadingHelper.swift
//  BTGConversion
//
//  Created by Yuri Chaves on 19/12/20.
//  Copyright © 2020 Yuri Chaves. All rights reserved.
//

import Foundation
import UIKit

class LoadingHelper {
    /* Show Progress Indicator */
    class func showProgressIndicator(view:UIView){
        
        view.isUserInteractionEnabled = false
        
        // Create and add the view to the screen.
        let progressIndicator = ProgressIndicator(text: "Carregando..")
        progressIndicator.tag = Constant.PROGRESS_INDICATOR_VIEW_TAG
        view.addSubview(progressIndicator)
        
    }
    
    /* Hide progress Indicator */
    class func hideProgressIndicator(view:UIView){
        
        view.isUserInteractionEnabled = true
        
        if let viewWithTag = view.viewWithTag(Constant.PROGRESS_INDICATOR_VIEW_TAG) {
            viewWithTag.removeFromSuperview()
        }
        
        
        
    }
}
