//
//  FavoritesList.swift
//  SysFonts
//
//  Created by actto on 10/14/15.
//  Copyright © 2015. All rights reserved.
//

import Foundation
private let _sharedInstance = FavoritesList();
class FavoritesList {
    //定义了一个变量sharedFavoriteList作为FavoritesList的类变量（类属性），class类型的使用 class @Swift old than v1.2
    class var sharedFavoriteList:FavoritesList {
        struct Singleton {
            //定义了一个常量instance作为Singleton的类变量（类属性），struct等值类型的使用static @Swift old than v1.2
            static var instance:FavoritesList?;
            static var token:dispatch_once_t = 0;
        }
    
        dispatch_once(&Singleton.token, {
            Singleton.instance = FavoritesList();
        });
        
        return Singleton.instance!;
    }
    //@Swift v1.2 and later,invoke :FavoritesList.sharedInstance,注意，这里没有括号，调用的是个属性
//    static let sharedInstance = FavoritesList();
    //Common usage in Swifit all versions,invoke:FavoritesList.sharedInstance(),注意，这里有括号，调用的是个方法
    class func sharedInstance() -> FavoritesList {
        return _sharedInstance;
    }
    
    private(set) var favorites:[String]!;
    
    private init() {
        let defaults = NSUserDefaults.standardUserDefaults();
        let storedFavorites = defaults.objectForKey("favorites") as? [String];
        favorites = storedFavorites != nil ? storedFavorites : [];
    }
    
    func addFavorite(fontName:String){
        if(!favorites.contains(fontName)){
            favorites.append(fontName);
            saveFavorites();
        }
    }
    
    func removeFavorite(fontName:String){
        if let index = favorites!.indexOf(fontName){
            favorites.removeAtIndex(index);
            saveFavorites();
        }
    }
    private func saveFavorites(){
        let defaults = NSUserDefaults.standardUserDefaults();
        defaults.setObject(favorites, forKey: "favorites");
        defaults.synchronize();
    }
}