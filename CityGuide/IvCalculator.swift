//
//  IvCalculator.swift
//  Go Pokedex
//
//  Created by antoine beneteau on 27/08/2016.
//  Copyright © 2016 Anna. All rights reserved.
//

import UIKit

func findLevels(stardust: Int, powered: Bool) ->[String] {
    if powered {
        return levelPoweredDictionary[stardust]!
    }
    return levelDictionary[stardust]!
}

func getCpMultiplier(level: String) -> Double{
    return cpMultiplier[level]!
}

func getHpIv(pokemon: Pokemon, hp: Int, m_multiplier: Double)-> Double {
    return Double(hp) / m_multiplier - Double(pokemon.stamina)!
}


func getIV(pokemon: Pokemon, cp: Int, hp: Int, stardust: Int, powered: Bool) -> [String:[Double]]{
    let levels = findLevels(stardust, powered: powered)
    var results = [String:[Double]]()
    for level in levels {
        let multiplier = getCpMultiplier(level)
        let hpIV = getHpIv(pokemon, hp: hp, m_multiplier: multiplier)
        var okForThisLevel: Bool = false
        if hpIV >= 0 && hpIV <= 15.0 {
            var a = 0.0
            var b = 0.0
            var res = [a,b]
            var resCopy = a
            while b <= 15.0 {
                a = 0
                while a <= 15.0 {
                    print("\(a) : \(b)")
                    let baseAttackModule = Double(pokemon.attack)! + a
                    let baseDefenseModule = sqrt(Double(pokemon.defense)! + b)
                    let baseStamModule = sqrt(Double(pokemon.stamina)! + hpIV)
                    if (Int(baseAttackModule * baseDefenseModule * baseStamModule * (multiplier * multiplier)) / 10) == cp {
                        res = [round(hpIV),round(a + b)]
                        results[level] = res
                        okForThisLevel = true
                        a = 15.0
                        b = 15.0
                    } else if ((baseAttackModule * baseDefenseModule * baseStamModule * (multiplier * multiplier)) / 10) > Double(cp) {
                        if  round(a + b) > resCopy{
                            resCopy = round(a + b)
                        }
                        results[level] = [hpIV,resCopy]
                        okForThisLevel = true
                        a = 15.0
                    }
                    a += 0.1
                }
                b += 0.1
            }
            a = 0.0
            b = 0.0
            while b <= 15.0 && a <= 15.0{
                print("\(a) : \(b)")
                let baseAttackModule = Double(pokemon.attack)! + a
                let baseDefenseModule = sqrt(Double(pokemon.defense)! + b)
                let baseStamModule = sqrt(Double(pokemon.stamina)! + hpIV)
                if (Int(baseAttackModule * baseDefenseModule * baseStamModule * (multiplier * multiplier)) / 10) == cp {
                    res = [round(hpIV),round(a + b)]
                    results[level] = res
                    okForThisLevel = true
                    a = 15.0
                    b = 15.0
                } else if ((baseAttackModule * baseDefenseModule * baseStamModule * (multiplier * multiplier)) / 10) > Double(cp) {
                    if  round(a + b) > resCopy{
                        resCopy = round(a + b)
                    }
                    results[level] = [hpIV,resCopy]
                    okForThisLevel = true
                    a = 15.0
                }
                a += 0.1
                b += 0.1
            }
        }
        if !okForThisLevel {
            results[level] = [1111.11111]
        }
        
    }
    return results
}
