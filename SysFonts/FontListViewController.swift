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
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let preferredTableViewFont = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline);
        cellPointSize = preferredTableViewFont.pointSize;
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        if showsFavorites {
            fontNames = FavoritesList.sharedInstance().favorites;
            tableView.reloadData();
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fontNames.count;
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as UITableViewCell;
        
        cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath);
        cell.textLabel?.text = fontNames[indexPath.row];
        cell.detailTextLabel?.text = fontNames[indexPath.row];

        // Configure the cell...

        return cell;
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let tmpString:NSString = NSString(string: fontNames[indexPath.row]);
        let size:CGSize = tmpString.sizeWithAttributes([NSFontAttributeName : fontForDisplay(atIndexPath: indexPath)]);
        return size.height + 20.0;
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell;
        let indexPath = tableView.indexPathForCell(cell);
        let font = fontForDisplay(atIndexPath: indexPath!);
        
        if segue.identifier == "ShowFontSizes" {
            let fontSizesVC = segue.destinationViewController as! FontSizesViewController;
            fontSizesVC.title = "Points of \(font.fontName)";
            fontSizesVC.font = font;
        } else {
            let fontInfoVC = segue.destinationViewController as! FontInfoViewController;
            fontInfoVC.title = "Info of \(font.fontName)";
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
