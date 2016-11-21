//
//  FontInfoViewController.swift
//  SysFonts
//
//  Created by actto on 10/15/15.
//  Copyright © 2015. All rights reserved.
//

import UIKit

class FontInfoViewController: UIViewController {
    var font:UIFont!;
    var favorited:Bool = false;
    
    @IBOutlet weak var fontSampleLabel:UILabel!
    @IBOutlet weak var fontSizeSlider:UISlider!;
    @IBOutlet weak var fontSizeLabel:UILabel!;
    @IBOutlet weak var favoriteSwitch:UISwitch!;
    
    //MARK: - UIViewController's LifeCircle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fontSampleLabel.font = font;
        fontSampleLabel.text = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            + "\nabcdefghijklmnopqrstuvwxyz"
            + "\n0123456789"
            + "\n中文字体";
        fontSizeSlider.value = Float(font.pointSize);
        fontSizeLabel.text = "\(Int(font.pointSize))";
        favoriteSwitch.isOn = favorited;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - IBAction Methods
    @IBAction func slideFontSize(_ sender: UISlider) {
        let newSize = roundf(sender.value);
        fontSampleLabel.font = font.withSize(CGFloat(newSize));
        fontSizeLabel.text = "\(Int(newSize))";
    }
    
    
    @IBAction func toggleFavorite(sender:UISwitch) {
        let favoritesList = FavoritesList.sharedInstance();
        
        if sender.isOn {
            favoritesList.addFavorite(fontName: font.fontName);
        } else {
            favoritesList.removeFavorite(fontName: font.fontName);
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
