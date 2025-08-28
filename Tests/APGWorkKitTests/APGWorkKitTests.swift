import Testing
@testable import APGWorkKit

@Test func versionTest() async throws {
    #expect(APGWork.version == "0.5.0")
}
