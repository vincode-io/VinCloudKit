# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

VinCloudKit is a Swift package that provides utilities for working with CloudKit. It simplifies CloudKit operations by handling common patterns like conflict resolution, error handling, retry logic, and zone management.

## Key Components

### Core Architecture
- **VCKModel Protocol**: Core protocol that models must implement for CloudKit synchronization. Includes conflict resolution methods for various data types (primitives, arrays, OrderedSets, NSAttributedString)
- **VCKZone Protocol**: Manages CloudKit record zones with automatic retry logic, error handling, and change token management
- **VCKError & VCKResult**: Comprehensive error handling and result refinement for CloudKit operations

### Conflict Resolution System
The package implements sophisticated 3-way merge algorithms:
- **VCKMergeScenario**: Evaluates client/ancestor/server states to determine merge strategy
- Supports merging of primitive types, arrays, OrderedSets, and NSAttributedString (iOS only)
- Handles complex scenarios like concurrent edits, deletions, and reordering

### Zone Management Features
- Automatic zone creation and subscription setup
- Change token persistence and migration
- Retry logic with exponential backoff for CloudKit operations
- Batch operation handling with automatic chunking for large datasets
- Platform-specific QoS optimization (different behaviors on macOS vs iOS)

## Build and Test Commands

```bash
# Build the package
swift build

# Run tests
swift test

# Run tests with verbose output
swift test --verbose

# Run a specific test
swift test --filter VCKModelTests.resolveOrderedSetConflictSimpleMerge
```

## Development Notes

### Dependencies
- Uses VinUtility package from vincode-io/VinUtility.git
- Minimum platform requirements: macOS 13.0, iOS 16.0
- Built with Swift 6.0 toolchain

### Testing
- Uses Swift Testing framework (not XCTest)
- Test suite focuses heavily on conflict resolution scenarios for OrderedSets
- MockModel class provides test implementation of VCKModel protocol

### Key Design Patterns
- Extensive use of async/await throughout the codebase
- MainActor isolation for model objects
- Protocol-oriented design with extensive use of default implementations
- Sendable conformance for thread safety
- Comprehensive error handling with localized error messages

### Platform Differences
The package handles platform-specific behaviors, particularly around CloudKit operation quality of service settings, where macOS and iOS have different performance characteristics.