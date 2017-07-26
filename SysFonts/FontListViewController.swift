//
//  FontListViewController.swift
//  SysFonts
//
//  Created by actto on 10/15/15.
//  Copyright © 2015. All rights reserved.
//

import UIKit

class FontListViewController: UITableViewController {

    
    var fontNames:[String] = [];
    var showsFavorites:Bool = false;
    
    private var cellPointSize:CGFloat?;
    private let cellIdentifier = "FontNameIdentifier";
    
    //MARK: - UIViewController's LifeCircle Methods
    override func viewDidLoad() {
        super.viewDidLoad();

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let preferredTableViewFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline);
        cellPointSize = preferredTableViewFont.pointSize;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
//        if showsFavorites {
//            fontNames = FavoritesList.sharedInstance().favorites;
//            tableView.reloadData();
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fontNames.count;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as UITableViewCell;
        
        cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath as NSIndexPath);
        cell.textLabel?.text = fontNames[indexPath.row];
        cell.detailTextLabel?.text = fontNames[indexPath.row];
        
        // Configure the cell...
        
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tmpString:NSString = NSString(string: fontNames[indexPath.row]);
        let size:CGSize = tmpString.size(attributes: [NSFontAttributeName : fontForDisplay(atIndexPath: indexPath as NSIndexPath)]);
        return size.height + 20.0;
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell;
        let indexPath = tableView.indexPath(for: cell);
        let font = fontForDisplay(atIndexPath: indexPath! as NSIndexPath);
        
        if segue.identifier == "ShowFontSizes" {
            let fontSizesVC = segue.destination as! FontSizesViewController;
            fontSizesVC.title = font.fontName;
            fontSizesVC.font = font;
        } else {
            let fontInfoVC = segue.destination as! FontInfoViewController;
            fontInfoVC.title = font.fontName;
            fontInfoVC.font = font;
            fontInfoVC.favorited = FavoritesList.sharedInstance().favorites.contains(font.fontName);
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    
    //MARK: - Utility Methods
    func fontForDisplay(atIndexPath indexPath:NSIndexPath) -> UIFont {
        let fontName = fontNames[indexPath.row] as String;
        return UIFont(name: fontName, size: cellPointSize!)!;
    }

}
