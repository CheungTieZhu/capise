//
//  CompanyDetail.swift
//  capisce
//
//  Created by zxbMacPro on 2017/12/25.
//  Copyright © 2017年 capisce. All rights reserved.
//

import Foundation
import Unbox

enum CompanyDetailServerKey: String {
    case business          = "business"
    case description       = "description"
    case companyIcon       = "companyIcon"
    case employeeNumber    = "employeeNumber"
    case ownerName         = "ownerName"
}

class CompanyDetail: Unboxable  {
    
    var business: String?
    var description: String?
    var companyIcon: String?
    var employeeNumber: Int?
    var ownerName: String?
    init() {
        //Initialization
    }
    
    func printAllData(){
        let allData = """
        business = \(business ?? "")
        description = \(description ?? "")
        companyIcon = \(companyIcon ?? "")
        """
        print(allData)
    }
    
    required init(unboxer: Unboxer) throws {
        self.business = try? unboxer.unbox(key: CompanyDetailServerKey.business.rawValue)
        self.description = try? unboxer.unbox(key: CompanyDetailServerKey.description.rawValue)
        self.companyIcon = try? unboxer.unbox(key: CompanyDetailServerKey.companyIcon.rawValue)
        self.employeeNumber = try? unboxer.unbox(key: CompanyDetailServerKey.employeeNumber.rawValue)
        self.ownerName = try? unboxer.unbox(key: CompanyDetailServerKey.ownerName.rawValue)
    }
}
