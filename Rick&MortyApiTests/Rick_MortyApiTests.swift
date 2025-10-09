import XCTest
import RealmSwift
@testable import Rick_MortyApi

@MainActor
final class RepositoryTests: XCTestCase {
    
    private var mockService: MockRickAndMortyService!
    private var realm: Realm!
    private var realmManager: RealmManager!
    private var repository: Repository!
    
    override func setUp() async throws {
        try await super.setUp()
        mockService = MockRickAndMortyService()
        let config = Realm.Configuration(
            inMemoryIdentifier: "TestRealm",
            deleteRealmIfMigrationNeeded: true
        )
        realm = try await Realm(configuration: config)
        realmManager = RealmManager(realm: realm)
        
        repository = Repository(service: mockService, realmManager: realmManager)
    }
    
    override func tearDown() async throws {
        repository = nil
        realmManager = nil
        realm = nil
        mockService = nil
        try await super.tearDown()
    }

    private func makeCharacter(id: Int = 1) -> Character {
        return Character(
            id: id,
            name: "Rick Sanchez \(id)",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: LocationReference(name: "Origin \(id)", url: ""),
            location: LocationReference(name: "Location \(id)", url: ""),
            image: "https://example.com/image\(id).jpg",
            episode: [],
            url: "https://rickandmortyapi.com/api/character/\(id)",
            created: "2017-11-04T18:48:46.250Z"
        )
    }
    
    private func makeEpisode(id: Int = 1) -> Episode {
        return Episode(
            id: id,
            name: "Pilot Episode \(id)",
            airDate: "December \(id), 2013",
            episode: "S01E0\(id)",
            characters: [],
            url: "https://rickandmortyapi.com/api/episode/\(id)",
            created: "2017-11-10T12:56:33.798Z"
        )
    }
    
    private func makeLocation(id: Int = 1) -> Location {
        return Location(
            id: id,
            name: "Earth \(id)",
            type: "Planet",
            dimension: "Dimension C-\(id)37",
            residents: [],
            url: "https://rickandmortyapi.com/api/location/\(id)",
            created: "2017-11-10T13:08:13.191Z"
        )
    }
    
    func testFetchNewCharacter_Success() async throws {
        let characterId = 42
        mockService.characterToReturn = makeCharacter(id: characterId)
        
        try await repository.fetchNewCharacter(id: characterId)
        
        let fetchedCharacters = repository.fetchCharacters(by: [characterId])
        XCTAssertEqual(fetchedCharacters.count, 1)
        XCTAssertEqual(fetchedCharacters.first?.id, characterId)
        XCTAssertEqual(fetchedCharacters.first?.name, "Rick Sanchez \(characterId)")
    }
    
    func testFetchNewCharacter_Error() async {
        mockService.errorToThrow = RickAndMortyServiceError.networkError(NSError(domain: "test", code: 404))
        
        do {
            try await repository.fetchNewCharacter(id: 1)
            XCTFail("Expected error not thrown")
        } catch {
            let characters = repository.fetchAllCharacters()
            XCTAssertEqual(characters.count, 0, "No characters should be saved on error")
        }
    }
    
    func testFetchAllCharacters() async throws {
        for id in 1...3 {
            mockService.characterToReturn = makeCharacter(id: id)
            try await repository.fetchNewCharacter(id: id)
        }
        
        let characters = repository.fetchAllCharacters()
        
        XCTAssertEqual(characters.count, 3)
        XCTAssertEqual(Set(characters.map { $0.id }), Set([1, 2, 3]))
    }
    
    func testFetchCharactersByIds() async throws {
        for id in 1...5 {
            mockService.characterToReturn = makeCharacter(id: id)
            try await repository.fetchNewCharacter(id: id)
        }
        
        let characters = repository.fetchCharacters(by: [2, 4])
        
        XCTAssertEqual(characters.count, 2)
        XCTAssertEqual(Set(characters.map { $0.id }), Set([2, 4]))
    }
    
    func testFetchNewEpisode_Success() async throws {
        let episodeId = 7
        mockService.episodeToReturn = makeEpisode(id: episodeId)
        
        try await repository.fetchNewEpisode(id: episodeId)
        
        let fetchedEpisodes = repository.fetchEpisodes(by: [episodeId])
        XCTAssertEqual(fetchedEpisodes.count, 1)
        XCTAssertEqual(fetchedEpisodes.first?.id, episodeId)
        XCTAssertEqual(fetchedEpisodes.first?.name, "Pilot Episode \(episodeId)")
    }
    
    func testFetchNewEpisode_Error() async {
        mockService.errorToThrow = RickAndMortyServiceError.unknown
        
        do {
            try await repository.fetchNewEpisode(id: 1)
            XCTFail("Expected error not thrown")
        } catch {
            let episodes = repository.fetchAllEpisodes()
            XCTAssertEqual(episodes.count, 0, "No episodes should be saved on error")
        }
    }
    
    func testFetchAllEpisodes() async throws {
        for id in 1...3 {
            mockService.episodeToReturn = makeEpisode(id: id)
            try await repository.fetchNewEpisode(id: id)
        }
        
        let episodes = repository.fetchAllEpisodes()
        
        XCTAssertEqual(episodes.count, 3)
        XCTAssertEqual(Set(episodes.map { $0.id }), Set([1, 2, 3]))
    }
    
    func testFetchEpisodesByIds() async throws {
        for id in 1...5 {
            mockService.episodeToReturn = makeEpisode(id: id)
            try await repository.fetchNewEpisode(id: id)
        }
        
        let episodes = repository.fetchEpisodes(by: [3, 5])
        
        XCTAssertEqual(episodes.count, 2)
        XCTAssertEqual(Set(episodes.map { $0.id }), Set([3, 5]))
    }
    
    func testFetchNewLocation_Success() async throws {
        let locationId = 9
        mockService.locationToReturn = makeLocation(id: locationId)
        
        try await repository.fetchNewLocation(id: locationId)
        
        let location = repository.fetchLocation(by: locationId)
        XCTAssertNotNil(location)
        XCTAssertEqual(location?.id, locationId)
        XCTAssertEqual(location?.name, "Earth \(locationId)")
    }
    
    func testFetchNewLocation_Error() async {
        mockService.errorToThrow = RickAndMortyServiceError.decodingError(NSError(domain: "test", code: 400))
        
        do {
            try await repository.fetchNewLocation(id: 1)
            XCTFail("Expected error not thrown")
        } catch {
            let locations = repository.fetchAllLocations()
            XCTAssertEqual(locations.count, 0, "No locations should be saved on error")
        }
    }
    
    func testFetchAllLocations() async throws {
        for id in 1...3 {
            mockService.locationToReturn = makeLocation(id: id)
            try await repository.fetchNewLocation(id: id)
        }
        
        let locations = repository.fetchAllLocations()
        
        XCTAssertEqual(locations.count, 3)
        XCTAssertEqual(Set(locations.map { $0.id }), Set([1, 2, 3]))
    }
}
