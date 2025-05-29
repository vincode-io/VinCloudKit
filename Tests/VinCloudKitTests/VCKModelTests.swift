//
//  Created by Maurice Parker on 5/10/25.
//

import Foundation
import CloudKit
import Testing
import OrderedCollections
@testable import VinCloudKit

@MainActor
final class VCKModelTests {
	
	@Test func resolveOrderedSetConflictNoClientChanges1() throws {
		let client: OrderedSet<String>? = ["a", "b", "c", "e", "d"]
		let ancestor: OrderedSet<String>? = nil
		let server: OrderedSet<String>? = ["a", "b", "c", "d", "e"]
		
		let merged = MockModel().merge(client: client, ancestor: ancestor, server: server)
		
		#expect(merged == ["a", "b", "c", "d", "e"])
	}
	
	@Test func resolveOrderedSetConflictNoClientChanges2() throws {
		let client: OrderedSet<String>? = ["a", "b", "c", "d", "e"]
		let ancestor: OrderedSet<String>? = nil
		let server: OrderedSet<String>? = ["z"]
		
		let merged = MockModel().merge(client: client, ancestor: ancestor, server: server)
		
		#expect(merged == ["z"])
	}
	
	@Test func resolveOrderedSetConflictNoServerData() throws {
		let client: OrderedSet<String>? = ["a", "b", "c", "d", "e"]
		var ancestor: OrderedSet<String>? = nil
		let server: OrderedSet<String>? = nil

		var merged = MockModel().merge(client: client, ancestor: ancestor, server: server)
		
		#expect(merged == ["a", "b", "c", "d", "e"])
		
		ancestor = ["a", "b", "c", "d"]

		merged = MockModel().merge(client: client, ancestor: ancestor, server: server)
		
		#expect(merged == ["a", "b", "c", "d", "e"])
	}
	
	@Test func resolveOrderedSetConflictSimpleMerge() throws {
		let client: OrderedSet<String>? = ["a", "b", "c", "d", "e"]
		let ancestor: OrderedSet<String>? = ["a", "b", "c", "d"]
		let server: OrderedSet<String>? = ["a", "b", "d", "c"]

		let merged = MockModel().merge(client: client, ancestor: ancestor, server: server)
		
		#expect(merged == ["a", "b", "d", "c", "e"])
	}

	@Test func resolveOrderedSetConflictMergeSameChange() throws {
		let client: OrderedSet<String>? = ["d", "c", "b", "a"]
		let ancestor: OrderedSet<String>? = ["a", "b", "c", "d"]
		let server: OrderedSet<String>? = ["d", "c", "b", "a"]

		let merged = MockModel().merge(client: client, ancestor: ancestor, server: server)
		
		#expect(merged == ["d", "c", "b", "a"])
	}

	@Test func resolveOrderedSetConflictMergeElementMove() throws {
		let client: OrderedSet<String>? = ["a", "d", "b", "c"]
		let ancestor: OrderedSet<String>? = ["a", "b", "c", "d"]
		let server: OrderedSet<String>? = ["d", "a", "b", "c"]

		let merged = MockModel().merge(client: client, ancestor: ancestor, server: server)
		
		#expect(merged == ["d", "a", "b", "c"])
	}

	@Test func resolveOrderedSetConflictMergeElementCrazyMove() throws {
		let client: OrderedSet<String>? = ["c", "d", "b", "a"]
		let ancestor: OrderedSet<String>? = ["a", "b", "c", "d"]
		let server: OrderedSet<String>? = ["d", "a", "c", "b"]

		let merged = MockModel().merge(client: client, ancestor: ancestor, server: server)
		
		#expect(merged == ["d", "c", "a", "b"])
	}

	@Test func resolveOrderedSetConflictMergeElementMoveAndClientDelete1() throws {
		let client: OrderedSet<String>? = ["a", "b", "c"]
		let ancestor: OrderedSet<String>? = ["a", "b", "c", "d"]
		let server: OrderedSet<String>? = ["a", "b", "d", "c"]

		let merged = MockModel().merge(client: client, ancestor: ancestor, server: server)
		
		#expect(merged == ["a", "b", "c"])
	}

	@Test func resolveOrderedSetConflictMergeElementMoveAndServerDelete1() throws {
		let client: OrderedSet<String>? = ["a", "b", "d", "c"]
		let ancestor: OrderedSet<String>? = ["a", "b", "c", "d"]
		let server: OrderedSet<String>? = ["a", "b", "c"]

		let merged = MockModel().merge(client: client, ancestor: ancestor, server: server)
		
		#expect(merged == ["a", "b", "c"])
	}

	@Test func resolveOrderedSetConflictMergeElementMoveAndClientDelete2() throws {
		let client: OrderedSet<String>? = ["b", "c", "d"]
		let ancestor: OrderedSet<String>? = ["a", "b", "c", "d"]
		let server: OrderedSet<String>? = ["a", "b", "d", "c"]

		let merged = MockModel().merge(client: client, ancestor: ancestor, server: server)
		
		#expect(merged == ["b", "d", "c"])
	}

	@Test func resolveOrderedSetConflictMergeElementMoveAndServerDelete2() throws {
		let client: OrderedSet<String>? = ["a", "b", "d", "c"]
		let ancestor: OrderedSet<String>? = ["a", "b", "c", "d"]
		let server: OrderedSet<String>? = ["b", "c", "d"]

		let merged = MockModel().merge(client: client, ancestor: ancestor, server: server)
		
		#expect(merged == ["b", "d", "c"])
	}

	@Test func resolveOrderedSetConflictMergeElementMoveAndClientDelete3() throws {
		let client: OrderedSet<String>? = ["b", "d"]
		let ancestor: OrderedSet<String>? = ["a", "b", "c", "d"]
		let server: OrderedSet<String>? = ["d", "c", "b", "a"]

		let merged = MockModel().merge(client: client, ancestor: ancestor, server: server)
		
		#expect(merged == ["d", "b"])
	}

	@Test func resolveOrderedSetConflictMergeElementMoveAndServerDelete3() throws {
		let client: OrderedSet<String>? = ["d", "c", "b", "a"]
		let ancestor: OrderedSet<String>? = ["a", "b", "c", "d"]
		let server: OrderedSet<String>? = ["d", "b"]

		let merged = MockModel().merge(client: client, ancestor: ancestor, server: server)
		
		#expect(merged == ["d", "b"])
	}

	@Test func resolveOrderedSetConflictMergeElementMoveAddAndClientDelete3() throws {
		let client: OrderedSet<String>? = ["b", "d"]
		let ancestor: OrderedSet<String>? = ["a", "b", "c", "d"]
		let server: OrderedSet<String>? = ["d", "c", "e", "b", "a"]

		let merged = MockModel().merge(client: client, ancestor: ancestor, server: server)
		
		#expect(merged == ["d", "e", "b"])
	}

	@Test func resolveOrderedSetConflictMergeElementMoveAddAndServerDelete3() throws {
		let client: OrderedSet<String>? = ["d", "c", "e", "b", "a"]
		let ancestor: OrderedSet<String>? = ["a", "b", "c", "d"]
		let server: OrderedSet<String>? = ["d", "b"]

		let merged = MockModel().merge(client: client, ancestor: ancestor, server: server)
		
		#expect(merged == ["d", "b", "e"])
	}

	@Test func resolveOrderedSetConflictMergeElementMoveAddAndClientAddDelete1() throws {
		let client: OrderedSet<String>? = ["b", "f", "d"]
		let ancestor: OrderedSet<String>? = ["a", "b", "c", "d"]
		let server: OrderedSet<String>? = ["d", "c", "e", "b", "a"]

		let merged = MockModel().merge(client: client, ancestor: ancestor, server: server)
		
		#expect(merged == ["f", "d", "e", "b"])
	}

	@Test func resolveOrderedSetConflictMergeElementMoveAddAndServerAddDelete1() throws {
		let client: OrderedSet<String>? = ["d", "c", "e", "b", "a"]
		let ancestor: OrderedSet<String>? = ["a", "b", "c", "d"]
		let server: OrderedSet<String>? = ["d", "f", "b"]

		let merged = MockModel().merge(client: client, ancestor: ancestor, server: server)
		
		#expect(merged == ["d", "f", "b", "e"])
	}

}

@MainActor
private final class MockModel: VCKModel {
	var isCloudKit: Bool = true
	var cloudKitMetaData: Data? = nil
	var isCloudKitMerging: Bool = false

	var cloudKitRecordID: CKRecord.ID {
		return .init(recordName: "")
	}
	
	func apply(_ error: CKError) {
	}
	
	func buildRecord() -> CKRecord? {
		return nil
	}
	
	func clearSyncData() {
	}
	
}
