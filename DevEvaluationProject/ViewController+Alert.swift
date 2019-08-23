//
//  ViewController+Alert.swift
//  DevEvaluationProject
//
//  Created by user on 8/23/19.
//  Copyright © 2019 Azarenkov Serhii. All rights reserved.
//

import UIKit
extension ViewController{
    func showAlert(message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
