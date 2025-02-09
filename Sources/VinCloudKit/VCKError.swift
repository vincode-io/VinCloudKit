//
//  VCKError.swift
//
//
//  Created by Maurice Parker on 10/31/23.
//

import Foundation
import CloudKit

public enum VCKError: LocalizedError {
	case ckError(CKError)
	case userDeletedZone
	case corruptAccount
	case maxChildCountExceeded
	case unknown
	
	public var errorDescription: String? {
		switch self {
		case .userDeletedZone:
			return String(localized: "error.text.user-deleted-data",
									 comment: "Error Message: The iCloud data was deleted.  Please remove the application iCloud account and add it again to continue using the application's iCloud support.")
		case .corruptAccount:
			return String(localized: "error.text.corrupt-account",
									 comment: "Error Message: There is an unrecoverable problem with your application iCloud account. Please make sure you have iCloud and iCloud Drive enabled in System Preferences. Then remove the application iCloud account and add it again.")
		case .maxChildCountExceeded:
			return String(localized: "error.text.max-child-count-exceeded",
						  comment: "Error Message: The maximum number of child rows that iCloud can sync is 750. This limit has been exceeded. Please reduce the number of child rows to continue syncing.")
		case .ckError(let ckError):
			switch ckError.code {
			case .accountTemporarilyUnavailable:
				return String(localized: "error.text.account-temporarily-unavailable",
							  comment: "Error Message: The iCloud Account is temporarily unavailable.")
			case .alreadyShared:
				return String(localized: "error.text.already-shared",
							  comment: "Error Message: Already Shared: a record or share cannot be saved because doing so would cause the same hierarchy of records to exist in multiple shares.")
			case .assetFileModified:
				return String(localized: "error.text.asset-file-modified",
							  comment: "Error Message: Asset File Modified: the content of the specified asset file was modified while being saved.")
			case .assetFileNotFound:
				return String(localized: "error.text.asset-file-not-found",
							  comment: "Error Message: Asset File Not Found: the specified asset file is not found.")
			case .badContainer:
				return String(localized: "error.text.bad-container",
							  comment: "Error Message: Bad Container: the specified container is unknown or unauthorized.")
			case .badDatabase:
				return String(localized: "error.text.bad-database",
							  comment: "Error Message: Bad Database: the operation could not be completed on the given database.")
			case .batchRequestFailed:
				return String(localized: "error.text.batch-request-failed",
							  comment: "Error Message: Batch Request Failed: the entire batch was rejected.")
			case .changeTokenExpired:
				return String(localized: "error.text.change-token-expired",
							  comment: "Error Message: Change Token Expired: the previous server change token is too old.")
			case .constraintViolation:
				return String(localized: "error.text.constraint-violation",
							  comment: "Error Message: Constraint Violation: the server rejected the request because of a conflict with a unique field.")
			case .incompatibleVersion:
				return String(localized: "error.text.incompatible-version",
							  comment: "Error Message: Incompatible Version: your app version is older than the oldest version allowed.")
			case .internalError:
				return String(localized: "error.text.internal-error",
							  comment: "Error Message: Internal Error: a nonrecoverable error was encountered by CloudKit.")
			case .invalidArguments:
				return String(localized: "error.text.invalid-arguments",
							  comment: "Error Message: Invalid Arguments: the specified request contains bad information.")
			case .limitExceeded:
				return String(localized: "error.text.limit-exceeded",
							  comment: "Error Message: Limit Exceeded: the request to the server is too large.")
			case .managedAccountRestricted:
				return String(localized: "error.text.managed-account-restricted",
							  comment: "Error Message: Managed Account Restricted: the request was rejected due to a managed-account restriction.")
			case .missingEntitlement:
				return String(localized: "error.text.missing-entitlement",
							  comment: "Error Message: Missing Entitlement: the app is missing a required entitlement.")
			case .networkUnavailable:
				return String(localized: "error.text.network-unavailable",
							  comment: "Error Message: Network Unavailable: the internet connection appears to be offline.")
			case .networkFailure:
				return String(localized: "error.text.network-failure",
							  comment: "Error Message: Network Failure: the internet connection appears to be offline.")
			case .notAuthenticated:
				return String(localized: "error.text.not-authenticated",
							  comment: "Error Message: Not Authenticated: to use the iCloud account, you must enable iCloud Drive. Go to device Settings, sign in to iCloud, then in the app settings, be sure the iCloud Drive feature is enabled.")
			case .operationCancelled:
				return String(localized: "error.text.operation-canceled",
							  comment: "Error Message: Operation Canceled: the operation was explicitly canceled.")
			case .partialFailure:
				return String(localized: "error.text.partial-failure",
							  comment: "Error Message: Partial Failure: some items failed, but the operation succeeded overall.")
			case .participantMayNeedVerification:
				return String(localized: "error.text.participant-may-need-verification",
							  comment: "Error Message: Participant May Need Verification: you are not a member of the share.")
			case .permissionFailure:
				return String(localized: "error.text.permission-failure",
							  comment: "Error Message: Permission Failure: to use this app, you must enable iCloud Drive. Go to device Settings, sign in to iCloud, then in the app settings, be sure the iCloud Drive feature is enabled.")
			case .quotaExceeded:
				return String(localized: "error.text.quota-exceeded",
							  comment: "Error Message: Quota Exceeded: saving would exceed your current iCloud storage quota.")
			case .referenceViolation:
				return String(localized: "error.text.reference-violation",
							  comment: "Error Message: Reference Violation: the target of a record's parent or share reference was not found.")
			case .requestRateLimited:
				return String(localized: "error.text.request-rate-limited",
							  comment: "Error Message: Request Rate Limited: transfers to and from the server are being rate limited at this time.")
			case .serverRecordChanged:
				return String(localized: "error.text.server-record-changed",
							  comment: "Error Message: Server Record Changed: the record was rejected because the version on the server is different.")
			case .serverRejectedRequest:
				return String(localized: "error.text.server-rejected-request",
							  comment: "Error Message: Server Rejected Request")
			case .serverResponseLost:
				return String(localized: "error.text.server-response-lost",
							  comment: "Error Message: Server Response Lost")
			case .serviceUnavailable:
				return String(localized: "error.text.service-unavailable",
							  comment: "Error Message: Service Unavailable: Please try again.")
			case .tooManyParticipants:
				return String(localized: "error.text.too-many-participants",
							  comment: "Error Message: Too Many Participants: a share cannot be saved because too many participants are attached to the share.")
			case .unknownItem:
				return String(localized: "error.text.unknown-item",
							  comment: "Error Message: Unknown Item: the specified record does not exist.")
			case .userDeletedZone:
				return String(localized: "error.text.user-deleted-zone",
							  comment: "Error Message: User Deleted Zone: the user has deleted this zone from the Settings UI.")
			case .zoneBusy:
				return String(localized: "error.text.zone-busy",
							  comment: "Error Message: Zone Busy: the server is too busy to handle the zone operation.")
			case .zoneNotFound:
				return String(localized: "error.text.zone-not-found",
							  comment: "Error Message: Zone Not Found: the specified record zone does not exist on the server.")
			default:
				return String(localized: "error.text.unknown-cloudkit-error",
							  comment: "Error Message: Unknown iCloud Error")
			}
		default:
			return String(localized: "error.text.unexpected-cloudkit-error",
						  comment: "Error Message: An unexpected CloudKit error occurred.")
		}
	}
}
