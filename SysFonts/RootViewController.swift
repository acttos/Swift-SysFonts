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
        
        familyNames = UIFont.familyNames as [String];
//        familyNames.sort();
        let preferredTableViewFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline);
        cellPointSize = preferredTableViewFont.pointSize;
        favoritesList = FavoritesList.sharedInstance();
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.tableView.reloadData();
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return favoritesList.favorites.isEmpty ? 1 : 2;
    }
    
    override func tableView(_:UITableView, numberOfRowsInSection section:Int) -> Int {
        return section == 0 ? familyNames.count : 1;
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "All Fonts" : "My Favorites";
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: familyCell, for: indexPath as IndexPath) as UITableViewCell;
            
            cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath as NSIndexPath);
            cell.textLabel?.text = familyNames[indexPath.row];
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 10.0);
            cell.detailTextLabel?.text = familyNames[indexPath.row];
            
            return cell;
        } else {
            return tableView.dequeueReusableCell(withIdentifier: favoritesCell, for: indexPath as IndexPath) as UITableViewCell;
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            let tmpString:NSString = NSString(string: familyNames[indexPath.row]);
            let size:CGSize = tmpString.size(attributes: [NSFontAttributeName : fontForDisplay(atIndexPath: indexPath as NSIndexPath)!]);
            return size.height + 25.0;
        } else {
            return 60;
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!;
        let listVC = segue.destination as! FontListViewController;
        
        if indexPath.section == 0 {
            let familyName = familyNames[indexPath.row];
            listVC.fontNames = UIFont.fontNames(forFamilyName: familyName) as [String];
            listVC.navigationItem.title = familyName;
            listVC.showsFavorites = false;
        } else {
            listVC.fontNames = favoritesList.favorites;
            listVC.navigationItem.title = "Favorites";
            listVC.showsFavorites = true;
        }
        
    }
    
    
    //MARK: - Utility Methods
    func fontForDisplay(atIndexPath indexPath:NSIndexPath) -> UIFont? {
        if indexPath.section == 0 {
            let familyName = familyNames[indexPath.row];
            let fontNames = UIFont.fontNames(forFamilyName: familyName);
            if fontNames.count > 0 {
                let fontName = UIFont.fontNames(forFamilyName: familyName).first;
            
                return UIFont(name: (fontName)!, size: cellPointSize);
            } else {
                return UIFont(name: familyName, size: cellPointSize);
            }
        } else {
            return nil;
        }
    }

}
