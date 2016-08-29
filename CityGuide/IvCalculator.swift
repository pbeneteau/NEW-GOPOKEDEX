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

func getHpIv(pokemon: Pokemon, hp: Int, m_multiplier: Double)-> Int {
    return Int(round(Double(hp) / m_multiplier - Double(pokemon.stamina)!))
}

func getIV(pokemon: Pokemon, cp: Int, hp: Int, stardust: Int, powered: Bool) -> [String:[Int]]{
    let levels = findLevels(stardust, powered: powered)
    var results = [String:[Int]]()
    for level in levels {
        let multiplier = getCpMultiplier(level)
        let hpIV = getHpIv(pokemon, hp: hp, m_multiplier: multiplier)
        if hpIV >= 0 {
            var a = 0
            var b = 0
            var res = [a,b]
            var okForThisLevel: Bool = false
            while b != 15 && !okForThisLevel {
                a = 0
                while a != 15 {
                    let baseAttackModule = Double(Int(pokemon.attack)! + a)
                    let baseDefenseModule = sqrt(Double(Int(pokemon.defense)! + b))
                    let baseStamModule = sqrt(Double(pokemon.stamina)! + Double(hpIV))
                    if (Int(baseAttackModule * baseDefenseModule * baseStamModule * (multiplier * multiplier)) / 10) >= cp {
                        res = [hpIV,a + b]
                        results[level] = res
                        okForThisLevel = true
                        break
                    }
                    a += 1
                }
                b += 1
            }
            a = 0
            while a != 15 && !okForThisLevel {
                b = 0
                while b != 15 {
                    let baseAttackModule = Double(Int(pokemon.attack)! + a)
                    let baseDefenseModule = sqrt(Double(Int(pokemon.defense)! + b))
                    let baseStamModule = sqrt(Double(pokemon.stamina)! + Double(hpIV))
                    if (Int(baseAttackModule * baseDefenseModule * baseStamModule * (multiplier * multiplier)) / 10) >= cp {
                        res = [hpIV,a + b]
                        results[level] = res
                        okForThisLevel = true
                        break
                    }
                    b += 1
                }
                a += 1
            }
            okForThisLevel = false
        }
        
    }
    return results
}
