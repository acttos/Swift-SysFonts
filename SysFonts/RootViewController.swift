//
//  RootViewController.swift
//  SysFonts
//
//  Created by actto on 10/14/15.
//  Copyright © 2015. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {

    private var familyNames:[String]!;
    private var cellPointSize:CGFloat!;
    private var favoritesList:FavoritesList!
    
    private let familyCell = "FamilyCellIdentifier";
    private let favoritesCell = "FavoritesCellIdentifier";
    
    // MARK: - UIViewController's LifeCyle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        familyNames = UIFont.familyNames() as [String];
//        familyNames.sort();
        let preferredTableViewFont = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline);
        cellPointSize = preferredTableViewFont.pointSize;
        favoritesList = FavoritesList.sharedInstance();
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        tableView.reloadData();
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return favoritesList.favorites.isEmpty ? 1 : 2;
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return section == 0 ? familyNames.count : 1;
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "All Font Families" : "My Favorite Fonts";
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(familyCell, forIndexPath: indexPath) as UITableViewCell;
            
            cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath);
            cell.textLabel?.text = familyNames[indexPath.row];
            cell.detailTextLabel?.font = UIFont.systemFontOfSize(10.0);
            cell.detailTextLabel?.text = familyNames[indexPath.row];
            
            return cell;
        } else {
            return tableView.dequeueReusableCellWithIdentifier(favoritesCell, forIndexPath: indexPath) as UITableViewCell;
        }
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            let tmpString:NSString = NSString(string: familyNames[indexPath.row]);
            let size:CGSize = tmpString.sizeWithAttributes([NSFontAttributeName : fontForDisplay(atIndexPath: indexPath)!]);
            return size.height + 25.0;
        } else {
            return 60;
        }
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!;
        let listVC = segue.destinationViewController as! FontListViewController;
        
        if indexPath.section == 0 {
            let familyName = familyNames[indexPath.row];
            listVC.fontNames = UIFont.fontNamesForFamilyName(familyName) as [String];
            listVC.navigationItem.title = "Fonts of '\(familyName)'";
            listVC.showsFavorites = false;
        } else {
            listVC.fontNames = favoritesList.favorites;
            listVC.navigationItem.title = "Fonts of Favorites";
            listVC.showsFavorites = true;
        }
        
    }
    
    
    //MARK: - Utility Methods
    func fontForDisplay(atIndexPath indexPath:NSIndexPath) -> UIFont? {
        if indexPath.section == 0 {
            let familyName = familyNames[indexPath.row];
            let fontNames = UIFont.fontNamesForFamilyName(familyName);
            if fontNames.count > 0 {
                let fontName = UIFont.fontNamesForFamilyName(familyName).first;
            
                return UIFont(name: (fontName)!, size: cellPointSize);
            } else {
                return UIFont(name: familyName, size: cellPointSize);
            }
        } else {
            return nil;
        }
    }

}
