//
//  TapperPathsStorageManager.swift
//  Tapper
//
//  Created by Yazan Tarifi on 08/01/2024.
//

import Foundation

public class TapperPathsStorageManager {
    
    public static var shared = TapperPathsStorageManager()
    
    private static let ADB_PATH_ENV_NAME = "adb_path"
    private static let TAPPER_PATH_ENV_NAME = "tapper_path"
    private static let NODE_PATH_ENV_NAME = "node_path"
    private static let NPM_PATH_ENV_NAME = "npm_path"
    
    public func updateApplicationPaths(
        adbPath: String,
        tapperCliPath: String,
        npmPath: String,
        nodePath: String
    ) {
        UserDefaults.standard.setValue(adbPath, forKey: TapperPathsStorageManager.ADB_PATH_ENV_NAME)
        UserDefaults.standard.setValue(tapperCliPath, forKey: TapperPathsStorageManager.TAPPER_PATH_ENV_NAME)
        UserDefaults.standard.setValue(npmPath, forKey: TapperPathsStorageManager.NPM_PATH_ENV_NAME)
        UserDefaults.standard.setValue(nodePath, forKey: TapperPathsStorageManager.NODE_PATH_ENV_NAME)
    }
    
    public func getAdbInstallationPath() -> String {
        return UserDefaults.standard.string(forKey: TapperPathsStorageManager.ADB_PATH_ENV_NAME) ?? ""
    }
    
    public func getNodeInstallationPath() -> String {
        return UserDefaults.standard.string(forKey: TapperPathsStorageManager.NODE_PATH_ENV_NAME) ?? ""
    }
    
    public func getNpmInstallationPath() -> String {
        return UserDefaults.standard.string(forKey: TapperPathsStorageManager.NPM_PATH_ENV_NAME) ?? ""
    }
    
    public func getTapperCliInstallationPath() -> String {
        return UserDefaults.standard.string(forKey: TapperPathsStorageManager.TAPPER_PATH_ENV_NAME) ?? ""
    }
}
