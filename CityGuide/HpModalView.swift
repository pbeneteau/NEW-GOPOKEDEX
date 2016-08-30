//
//  ModalView.swift
//
//  Created by Beneteau Antoine on 2/11/15.
//  Copyright (c) 2016 Tastyapp. All rights reserved.
//

import UIKit

protocol hpModalViewProtocol {
    func passHp(hp:Int)
}

class HpModalView: UIView {
    var bottomButtonHandler: (() -> Void)?
    var closeButtonHandler: (() -> Void)?
    
    @IBOutlet weak var hpTextField: UITextField!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet private weak var bottomButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    var vc: IVViewController!
    
    class func instantiateFromNib() -> HpModalView {
        let view = UINib(nibName: "HpModalView", bundle: nil).instantiateWithOwner(nil, options: nil).first as! HpModalView
        
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure()
        self.initTextField(hpTextField)
    }
    
    private func configure() {
        self.contentView.layer.cornerRadius = 5.0
        self.closeButton.layer.cornerRadius = CGRectGetHeight(self.closeButton.bounds) / 2.0
        self.closeButton.layer.shadowColor = UIColor.blackColor().CGColor
        self.closeButton.layer.shadowOffset = CGSizeZero
        self.closeButton.layer.shadowOpacity = 0.3
        self.closeButton.layer.shadowRadius = 2.0
    }
    
    @IBAction func handleBottomButton(sender: UIButton) {
        self.bottomButtonHandler?()
        if let text = hpTextField.text where !text.isEmpty
        {
            vc.passHp(Int(hpTextField.text!)!)
        } else {
            print("bad entry")
            vc.hpOK = true
        }

    }
    @IBAction func handleCloseButton(sender: UIButton) {
        self.closeButtonHandler?()
        if let text = hpTextField.text where !text.isEmpty
        {
            vc.passHp(Int(hpTextField.text!)!)
        } else {
            print("bad entry")
            vc.hpOK = true
        }
    }
    
    func initTextField(textField: UITextField) {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 101.0/255, green: 105.0/255, blue: 113.0/255, alpha: 1.0)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(HpModalView.doneButtonAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true

        textField.inputAccessoryView = toolBar
    }
    
    func doneButtonAction()
    {
        self.hpTextField.resignFirstResponder()
        self.hpTextField.resignFirstResponder()
    }
}