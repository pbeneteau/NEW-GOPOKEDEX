//
//  Types.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 27/08/2016.
//  Copyright © 2016 Anna. All rights reserved.
//

import UIKit

class Type {
    private var _id: String!
    private var _name: String!
    private var _color: UIColor!
    private var _againstSpecies: [String: [String]]!
    
    var id: String {
        return _id
    }
    
    var name: String {
        return _name
    }
    
    var color: UIColor {
        return _color
    }
    
    var againstSpecies:[String: [String]] {
        return _againstSpecies
    }
    
    init() {
        self._againstSpecies = [:]
        self._againstSpecies.removeAll()
        self.initAgainst()
        self._name = ""
        self._color = TYPES["Normal"]![1] as! UIColor
    }
    
    init(id: String, name: String) {
        self._againstSpecies = [:]
        self._againstSpecies.removeAll()
        self.initAgainst()
        self._id = id
        self._name = name
        self._color = TYPES[name]![1] as! UIColor
    }
    
    func initAgainst() {
        self._againstSpecies = [
            "Normal": [],
            "Fighting": [],
            "Flying": [],
            "Poison": [],
            "Ground": [],
            "Rock": [],
            "Bug": [],
            "Ghost": [],
            "Steel": [],
            "Fire": [],
            "Water": [],
            "Grass": [],
            "Electric": [],
            "Psychic": [],
            "Ice": [],
            "Dragon": [],
            "Dark": [],
            "Fairy": [],
        ]
    }
    
    func addAgainst(against: String, stats: [String]) {
        self._againstSpecies[against] = stats
    }
    
}

func initAllTypes() -> [Type] {
    let typesCVS = CSVReader(fileName: "GoPokedex_TypesFinal")
    var typeList = [Type]()
    let type = Type(id: typesCVS.rows[0]["#"]!, name: typesCVS.rows[0]["Move Types"]!)
    typeList.removeAll()
    typeList.append(type)
    for row in typesCVS.rows {
        let type_ = Type(id: row["#"]!, name: row["Move Types"]!)
        if type_.name == typeList[typeList.count - 1].name {
            var stat: String = "equal"
            var multip: String = "1.0"
            if row["Damage Multipliers"]! == "1.25" {
                stat = "strong"
                multip = "1.25"
            } else if row["Damage Multipliers"]! == "0.80" {
                stat = "weak"
                multip = "0.80"
            }
            typeList[typeList.count - 1].addAgainst(row["Species Types"]!, stats: [stat,multip])
        } else {
            typeList.append(type_)
        }
    }
    return typeList
}

//var stat: String = "equal"
//if row["Damage Multipliers"]! == "1.0" {
//    stat = "equal"
//} else if row["Damage Multipliers"]! == "1.25" {
//    stat = "strong"
//} else if row["Damage Multipliers"]! == "0.8" {
//    stat = "weak"
//}
//typeList[typeList.count - 1].addAgainst(type_.name, stats: [stat,row["Species Types"]!])







