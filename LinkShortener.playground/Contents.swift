//: Playground - noun: a place where people can play

import UIKit

//: Playground - noun: a place where people can play

import UIKit

var keys = [String]()

var values = [String]()

extension Array {
    func contains<T where T : Equatable>(obj: T) -> Bool {
        return self.filter({$0 as? T == obj}).count > 0
    }
}

var linkDictionary = [String: String]()

let magicNumber = 6
let maxSize = 5

func randomLimitedString (size: Int) -> NSString {
    
    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    
    let randomString : NSMutableString = NSMutableString()
    
    for _ in 1...size {
        let length = UInt32 (letters.length)
        let rand = arc4random_uniform(length)
        randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
    }
    
    return randomString
}

func linkShortener(link: String) -> String {
    
    var testKey = randomLimitedString(magicNumber)
    if keys.contains(testKey) { testKey = randomLimitedString(magicNumber) }
    
    if (values.contains(link)) {
        return keys[values.indexOf(link)!]
    } else if (keys.count == maxSize) {
        linkDictionary.removeValueForKey(keys[0])
        keys.removeAtIndex(0)
        values.removeAtIndex(0)
        linkDictionary.updateValue(link, forKey: testKey as String)
        keys.append(testKey as String)
        values.append(link)
        return testKey as String
    } else {
        linkDictionary.updateValue(link, forKey: testKey as String)
        keys.append(testKey as String)
        values.append(link)
        return testKey as String
    }
}

func linkRetriever(link: String) -> String {
    if keys.contains(link) {
        return values[keys.indexOf(link)!]
    } else {
        print("Key does not exist")
        return "Key does not exist"
    }
    
}


// Tests

// Attempt to fill queue, for testing purposes max size is 5

var tester = linkShortener("www.codefellows.com")

var dummyLinks = ["www.google.com", "www.facebook.com", "www.twitter.com", "www.amazon.com"]

for link in dummyLinks {
    linkShortener(link)
}

print("Full queue keys: \(keys)")
print("Full queue values: \(values)")
print("Full queue dictionary: \(linkDictionary)")

print(linkDictionary)

print("Test to make sure www.codefellows.com returns the same short link: \(linkRetriever(keys[0]))")

print("Test to make sure www.codefellows.com returns the same short link: \(linkRetriever(tester))")

print("Test to make sure adding a new link pushes oldest link off queue: \(linkShortener("www.tidal.com")) \(linkDictionary) \(keys) \(values))")