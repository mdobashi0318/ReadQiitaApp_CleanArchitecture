//
//  AlertManager.swift
//  ReadQiitaApp_CleanArchitecture
//
//  Created by 土橋正晴 on 2024/10/06.
//

import Foundation
import UIKit


@MainActor
struct AlertManager {
    
    enum AlertType: CaseIterable {
        case retry, ok
    }
    
    /// アラートを表示する
    /// - Parameters:
    ///   - vc: ViewController
    ///   - type: 出すアラートのタイプを設定する
    static func showAlert(_ vc: UIViewController, type: AlertType, title: String? = nil, message: String, didTapPositiveButton: ((UIAlertAction) -> Void)? = nil, didTapNegativeButton: ((UIAlertAction) -> Void)? = nil) {
        
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        switch type {
        case .retry:
            controller.addAction(UIAlertAction(title: "再接続",
                                               style: .default,
                                               handler: didTapPositiveButton)
            )
            
            controller.addAction(UIAlertAction(title: "閉じる",
                                               style: .cancel,
                                               handler: didTapNegativeButton)
            )
        case .ok:
            controller.addAction(UIAlertAction(title: "OK",
                                               style: .cancel,
                                               handler: didTapPositiveButton))
        }
        
        vc.present(controller, animated: true, completion: nil)
    }
    
    
    static func showActionSheet(_ vc: UIViewController, sender: UIBarButtonItem, title: String? = nil, message: String, actions: [UIAlertAction], didTapCancelButton: ((UIAlertAction)->())? = nil) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        
        actions.forEach {
            controller.addAction($0)
        }
        controller.addAction(UIAlertAction(title: "キャンセル",
                                           style: .cancel,
                                           handler: didTapCancelButton)
        )
        controller.popoverPresentationController?.barButtonItem = sender
        vc.present(controller, animated: true, completion: nil)
    }
    
}
