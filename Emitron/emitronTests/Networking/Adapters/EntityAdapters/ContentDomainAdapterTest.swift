// Copyright (c) 2022 Razeware LLC
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
// distribute, sublicense, create a derivative work, and/or sell copies of the
// Software in any work that is designed, intended, or marketed for pedagogical or
// instructional purposes related to programming, coding, application development,
// or information technology.  Permission for such use, copying, modification,
// merger, publication, distribution, sublicensing, creation of derivative works,
// or sale is expressly withheld.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import XCTest
@testable import Emitron

class ContentDomainAdapterTest: XCTestCase {
  func testCorrectlyBuildsFromRelationships() throws {
    let relationships = [
      EntityRelationship(name: "", from: EntityIdentity(id: 12, type: .content), to: EntityIdentity(id: 21, type: .attachment)),
      EntityRelationship(name: "", from: EntityIdentity(id: 23, type: .content), to: EntityIdentity(id: 34, type: .domain)),
      EntityRelationship(name: "", from: EntityIdentity(id: 45, type: .content), to: EntityIdentity(id: 56, type: .domain)),
      EntityRelationship(name: "", from: EntityIdentity(id: 67, type: .content), to: EntityIdentity(id: 78, type: .category))
    ]
    
    let contentDomains = try ContentDomainAdapter.process(relationships: relationships)
    
    XCTAssertEqual(2, contentDomains.count)
    XCTAssertEqual(34, contentDomains[0].domainID)
    XCTAssertEqual(23, contentDomains[0].contentID)
    XCTAssertEqual(56, contentDomains[1].domainID)
    XCTAssertEqual(45, contentDomains[1].contentID)
    XCTAssertNil(contentDomains[0].id)
    XCTAssertNil(contentDomains[1].id)
  }
  
  func testDoesNotBuildContentCategoriesForInverseRelationships() throws {
    let relationships = [
      EntityRelationship(name: "", from: EntityIdentity(id: 12, type: .content), to: EntityIdentity(id: 21, type: .attachment)),
      EntityRelationship(name: "", from: EntityIdentity(id: 23, type: .domain), to: EntityIdentity(id: 34, type: .content)),
      EntityRelationship(name: "", from: EntityIdentity(id: 45, type: .domain), to: EntityIdentity(id: 56, type: .content)),
      EntityRelationship(name: "", from: EntityIdentity(id: 67, type: .content), to: EntityIdentity(id: 78, type: .category))
    ]
    
    let contentDomains = try ContentDomainAdapter.process(relationships: relationships)
    
    XCTAssertEqual(0, contentDomains.count)
  }
}
