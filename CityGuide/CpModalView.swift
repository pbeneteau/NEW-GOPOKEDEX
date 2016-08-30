//
//  CpModalView.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 30/08/2016.
//  Copyright © 2016 TastyApp. All rights reserved.
//

import UIKit

protocol cpModalViewProtocol {
    func passCp(cp:Int)
}

class CpModalView: UIView {

    var bottomButtonHandler: (() -> Void)?
    var closeButtonHandler: (() -> Void)?
    
    @IBOutlet weak var cpTextField: UITextField!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet private weak var bottomButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    var vc: IVViewController!
    
    class func instantiateFromNib() -> CpModalView {
        let view = UINib(nibName: "CpModalView", bundle: nil).instantiateWithOwner(nil, options: nil).first as! CpModalView
        
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure()
        self.initTextField(cpTextField)
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
        if let text = cpTextField.text where !text.isEmpty
        {
            vc.passCp(Int(cpTextField.text!)!)
        } else {
            print("bad entry")
            vc.cpOK = true
        }
        
    }
    @IBAction func handleCloseButton(sender: UIButton) {
        self.closeButtonHandler?()
        if let text = cpTextField.text where !text.isEmpty
        {
            vc.passCp(Int(cpTextField.text!)!)
        } else {
            print("bad entry")
            vc.cpOK = true
        }
    }
    
    func initTextField(textField: UITextField) {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 101.0/255, green: 105.0/255, blue: 113.0/255, alpha: 1.0)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CpModalView.doneButtonAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        textField.inputAccessoryView = toolBar
    }
    
    func doneButtonAction()
    {
        self.cpTextField.resignFirstResponder()
        self.cpTextField.resignFirstResponder()
    }

}
