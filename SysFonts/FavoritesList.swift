//
//  FavoritesList.swift
//  SysFonts
//
//  Created by actto on 10/14/15.
//  Copyright © 2015. All rights reserved.
//

import Foundation

class FavoritesList {
    static let _sharedInstance:FavoritesList = {
        let instance = FavoritesList();
        return instance;
    }();
    //定义了一个变量sharedFavoriteList作为FavoritesList的类变量（类属性），class类型的使用 class @Swift old than v1.2
    class var sharedFavoriteList:FavoritesList {
        
        return _sharedInstance;
    }
    //@Swift v1.2 and later,invoke :FavoritesList.sharedInstance,注意，这里没有括号，调用的是个属性
//    static let sharedInstance = FavoritesList();
    //Common usage in Swifit all versions,invoke:FavoritesList.sharedInstance(),注意，这里有括号，调用的是个方法
    class func sharedInstance() -> FavoritesList {
        return _sharedInstance;
    }
    
    private(set) var favorites:[String]!;
    
    private init() {
        let defaults = UserDefaults.standard;
        let storedFavorites = defaults.object(forKey: "favorites") as? [String];
        favorites = storedFavorites != nil ? storedFavorites : [];
    }
    
    func addFavorite(fontName:String){
        if(!favorites.contains(fontName)){
            favorites.append(fontName);
            saveFavorites();
        }
    }
    
    func removeFavorite(fontName:String){
        if let index = favorites!.index(of: fontName){
            favorites.remove(at: index);
            saveFavorites();
        }
    }
    private func saveFavorites(){
        let defaults = UserDefaults.standard;
        defaults.set(favorites, forKey: "favorites");
        defaults.synchronize();
    }
}
