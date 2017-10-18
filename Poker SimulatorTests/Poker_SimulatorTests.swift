//
//  Poker_SimulatorTests.swift
//  Poker SimulatorTests
//
//  Created by Edward Huang on 10/15/17.
//  Copyright © 2017 Eddie Huang. All rights reserved.
//

import XCTest
@testable import Poker_Simulator

class Poker_SimulatorTests: XCTestCase {
    
    var hand = [Card]()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        hand.removeAll()
    }
    
    func testStraightFlush() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        hand.append(Card(suit: .spades, value: 14))
        hand.append(Card(suit: .spades, value: 13))
        hand.append(Card(suit: .spades, value: 12))
        hand.append(Card(suit: .spades, value: 11))
        hand.append(Card(suit: .spades, value: 10))
        
        hand.append(Card(suit: .hearts, value: 5))
        hand.append(Card(suit: .diamonds, value: 14))
        
        Card.shuffle(cards: &hand)
        
        XCTAssertEqual(Hand(cards: hand).handType, HandType.straightFlush)
    }
    
    func testStraightFlush2() {
        hand.append(Card(suit: .clubs, value: 14))
        hand.append(Card(suit: .clubs, value: 2))
        hand.append(Card(suit: .clubs, value: 3))
        hand.append(Card(suit: .clubs, value: 4))
        hand.append(Card(suit: .clubs, value: 5))
        
        hand.append(Card(suit: .hearts, value: 7))
        hand.append(Card(suit: .spades, value: 8))
        
        Card.shuffle(cards: &hand)
        
        XCTAssertEqual(Hand(cards: hand).handType, HandType.straightFlush)
    }
    
    func testFlush() {
        
        hand.append(Card(suit: .spades, value: 2))
        hand.append(Card(suit: .spades, value: 5))
        hand.append(Card(suit: .spades, value: 7))
        hand.append(Card(suit: .spades, value: 10))
        hand.append(Card(suit: .spades, value: 11))
        
        hand.append(Card(suit: .hearts, value: 14))
        hand.append(Card(suit: .diamonds, value: 4))
        
        Card.shuffle(cards: &hand)
        
        XCTAssertEqual(Hand(cards: hand).handType, HandType.flush)
    }
    
    func testStraight() {
        hand.append(Card(suit: .clubs, value: 14))
        hand.append(Card(suit: .diamonds, value: 2))
        hand.append(Card(suit: .hearts, value: 3))
        hand.append(Card(suit: .spades, value: 4))
        hand.append(Card(suit: .clubs, value: 5))
        
        hand.append(Card(suit: .diamonds, value: 10))
        hand.append(Card(suit: .diamonds, value: 11))
        
        Card.shuffle(cards: &hand)
        
        XCTAssertEqual(Hand(cards: hand).handType, HandType.straight)
    }
    
    func testStraight2() {
        hand.append(Card(suit: .clubs, value: 14))
        hand.append(Card(suit: .diamonds, value: 13))
        hand.append(Card(suit: .hearts, value: 12))
        hand.append(Card(suit: .spades, value: 11))
        hand.append(Card(suit: .clubs, value: 10))
        
        hand.append(Card(suit: .diamonds, value: 10))
        hand.append(Card(suit: .diamonds, value: 11))
        
        Card.shuffle(cards: &hand)
        
        XCTAssertEqual(Hand(cards: hand).handType, HandType.straight)
    }
    
    func testFourOfAKind() {
        hand.append(Card(suit: .clubs, value: 2))
        hand.append(Card(suit: .diamonds, value: 2))
        hand.append(Card(suit: .hearts, value: 2))
        hand.append(Card(suit: .spades, value: 2))
        
        hand.append(Card(suit: .clubs, value: 3))
        hand.append(Card(suit: .diamonds, value: 3))
        hand.append(Card(suit: .spades, value: 3))
        
        Card.shuffle(cards: &hand)
        
        XCTAssertEqual(Hand(cards: hand).handType, HandType.fourOfAKind)
    }
    
    func testFourOfAKind2() {
        hand.append(Card(suit: .clubs, value: 2))
        hand.append(Card(suit: .diamonds, value: 2))
        hand.append(Card(suit: .hearts, value: 2))
        hand.append(Card(suit: .spades, value: 2))
        
        hand.append(Card(suit: .clubs, value: 3))
        hand.append(Card(suit: .diamonds, value: 4))
        hand.append(Card(suit: .spades, value: 5))
        
        Card.shuffle(cards: &hand)
        
        XCTAssertEqual(Hand(cards: hand).handType, HandType.fourOfAKind)
    }
    
    func testFullHouse() {
        hand.append(Card(suit: .clubs, value: 2))
        hand.append(Card(suit: .diamonds, value: 2))
        hand.append(Card(suit: .hearts, value: 2))
        
        hand.append(Card(suit: .clubs, value: 3))
        hand.append(Card(suit: .diamonds, value: 3))
        
        hand.append(Card(suit: .spades, value: 5))
        hand.append(Card(suit: .spades, value: 5))
        
        Card.shuffle(cards: &hand)
        
        XCTAssertEqual(Hand(cards: hand).handType, HandType.fullHouse)
    }
    
    func testFullHouse2() {
        hand.append(Card(suit: .clubs, value: 2))
        hand.append(Card(suit: .diamonds, value: 2))
        hand.append(Card(suit: .hearts, value: 2))
        
        hand.append(Card(suit: .clubs, value: 3))
        hand.append(Card(suit: .diamonds, value: 3))
        
        hand.append(Card(suit: .spades, value: 5))
        hand.append(Card(suit: .spades, value: 4))
        
        Card.shuffle(cards: &hand)
        
        XCTAssertEqual(Hand(cards: hand).handType, HandType.fullHouse)
    }
    
    func testThreeOfAKind() {
        hand.append(Card(suit: .clubs, value: 14))
        hand.append(Card(suit: .diamonds, value: 14))
        hand.append(Card(suit: .hearts, value: 14))
        
        hand.append(Card(suit: .clubs, value: 4))
        hand.append(Card(suit: .diamonds, value: 3))
        hand.append(Card(suit: .hearts, value: 2))
        hand.append(Card(suit: .spades, value: 6))

        Card.shuffle(cards: &hand)
        
        XCTAssertEqual(Hand(cards: hand).handType, HandType.threeOfAKind)
    }
    
    func testTwoPair() {
        hand.append(Card(suit: .clubs, value: 14))
        hand.append(Card(suit: .diamonds, value: 14))
        
        hand.append(Card(suit: .clubs, value: 4))
        hand.append(Card(suit: .diamonds, value: 4))
        
        hand.append(Card(suit: .hearts, value: 2))
        hand.append(Card(suit: .spades, value: 2))
        
        hand.append(Card(suit: .clubs, value: 10))
        
        Card.shuffle(cards: &hand)
        
        XCTAssertEqual(Hand(cards: hand).handType, HandType.twoPair)
    }
    
    func testTwoPair2() {
        hand.append(Card(suit: .clubs, value: 14))
        hand.append(Card(suit: .diamonds, value: 14))
        
        hand.append(Card(suit: .clubs, value: 4))
        hand.append(Card(suit: .diamonds, value: 4))
        
        hand.append(Card(suit: .hearts, value: 2))
        hand.append(Card(suit: .spades, value: 7))
        
        hand.append(Card(suit: .clubs, value: 10))
        
        Card.shuffle(cards: &hand)
        
        XCTAssertEqual(Hand(cards: hand).handType, HandType.twoPair)
    }
    
    func testPair() {
        hand.append(Card(suit: .clubs, value: 14))
        hand.append(Card(suit: .diamonds, value: 14))
        
        hand.append(Card(suit: .clubs, value: 4))
        hand.append(Card(suit: .diamonds, value: 9))
        
        hand.append(Card(suit: .hearts, value: 2))
        hand.append(Card(suit: .spades, value: 7))
        
        hand.append(Card(suit: .clubs, value: 10))
        
        Card.shuffle(cards: &hand)
        
        XCTAssertEqual(Hand(cards: hand).handType, HandType.onePair)
    }
    
    func testHighCard() {
        hand.append(Card(suit: .clubs, value: 14))
        hand.append(Card(suit: .diamonds, value: 13))
        
        hand.append(Card(suit: .clubs, value: 4))
        hand.append(Card(suit: .diamonds, value: 9))
        
        hand.append(Card(suit: .hearts, value: 2))
        hand.append(Card(suit: .spades, value: 7))
        
        hand.append(Card(suit: .clubs, value: 10))
        
        Card.shuffle(cards: &hand)
        
        XCTAssertEqual(Hand(cards: hand).handType, HandType.highCard)
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
