//
//  UserServiceImplementationTest.swift
//  GitHubUsers
//
//  Created by Kapam6a on 13.04.17.
//  Copyright © 2017 NoNameOrganization. All rights reserved.
//

import XCTest
@testable import GitHubUsers

class MockNetworkClient: NetworkClient {
    var sendCallCount: Int
    
    init() {
        sendCallCount = 0
    }
    
    func send(request: URLRequest, success: @escaping (Data) -> Void, failure: @escaping (Error) -> Void) {
        sendCallCount += 1
        success(Data())
        failure(NSError(domain: "Domain", code: 0, userInfo: nil))
    }
}

class MockUserMapper: UserMapper {
    var mapUsersCallCount: Int
    var mapUserCallCount: Int
    
    init() {
        mapUsersCallCount = 0
        mapUserCallCount = 0
    }
    
    func mapUsers(_ data: Data) -> [User] {
        mapUsersCallCount += 1
        return []
    }
    
    func mapUser(_ data: Data) -> FullUser {
        mapUserCallCount += 1
        return FullUser(avatarURL: "",
                              login: "",
                              id: 0,
                              url: "",
                              name: nil,
                              company: nil,
                              location: nil,
                              email: nil,
                              repos: 0,
                              followers: 0)
    }
}

class MockRequestFactory: RequestFactory {
    var getUsersRequestCallCount: Int
    var getUserRequestCallCount: Int
    
    init() {
        getUsersRequestCallCount = 0
        getUserRequestCallCount = 0
    }
    
    func getUsersRequest(since userNumber: Int) -> URLRequest {
        getUsersRequestCallCount += 1
        return URLRequest(url: URL(string: "https://api.github.com")!)
    }
    
    func getUserRequest(with id: Int) -> URLRequest {
        getUserRequestCallCount += 1
        return URLRequest(url: URL(string: "https://api.github.com")!)
    }
}

class UserServiceImplementationTests: XCTestCase {
    private var mockNetworkClient: MockNetworkClient!
    private var mockUserMapper: MockUserMapper!
    private var mockRequestFactory: MockRequestFactory!
    private var service: UserServiceImplementation!

    override func setUp() {
        super.setUp()
        
        mockNetworkClient = MockNetworkClient()
        mockUserMapper = MockUserMapper()
        mockRequestFactory = MockRequestFactory()
        service = UserServiceImplementation(networkClient: mockNetworkClient,
                                            mapper: mockUserMapper,
                                            requestFactory: mockRequestFactory)
    }
    
    override func tearDown() {
        mockNetworkClient = nil
        mockUserMapper = nil
        mockRequestFactory = nil
        service = nil
        
        super.tearDown()
    }
    
    func testThatServiceCallsGetUsersSuccesBlock() {
        //given
        let testExpectation = expectation(description: "Long expectation for testThatServiceCallsGetUsersSuccesBlock")
        
        //when
        service.getUsers(since: 0, success: { users in
            testExpectation.fulfill()
        }) { error in
        }
        
        //then
        waitForExpectations(timeout: 1) { error in
            XCTAssertEqual(self.mockNetworkClient.sendCallCount, 1)
            XCTAssertEqual(self.mockUserMapper.mapUsersCallCount, 1)
            XCTAssertEqual(self.mockRequestFactory.getUsersRequestCallCount, 1)
        }
    }
    
    func testThatServiceCallsGetUsersFailureBlock() {
        //given
        let testExpectation = expectation(description: "Long expectation for testThatServiceCallsGetUsersFailureBlock")
        
        //when
        service.getUsers(since: 0, success: { users in
        }) { error in
            testExpectation.fulfill()
        }
        
        //then
        waitForExpectations(timeout: 1) { error in
            XCTAssertEqual(self.mockNetworkClient.sendCallCount, 1)
            XCTAssertEqual(self.mockUserMapper.mapUsersCallCount, 1)
            XCTAssertEqual(self.mockRequestFactory.getUsersRequestCallCount, 1)
        }
    }
    
    func testThatServiceCallsGetUserSuccesBlock() {
        //given
        let testExpectation = expectation(description: "Long expectation for testThatServiceCallsGetUserSuccesBlock")
        
        //when
        service.getUser(with: 0, success: { users in
            testExpectation.fulfill()
        }) { error in
        }
        
        //then
        waitForExpectations(timeout: 1) { error in
            XCTAssertEqual(self.mockNetworkClient.sendCallCount, 1)
            XCTAssertEqual(self.mockUserMapper.mapUserCallCount, 1)
            XCTAssertEqual(self.mockRequestFactory.getUserRequestCallCount, 1)
        }
    }
    
    func testThatServiceCallsGetUserFailureBlock() {
        //given
        let testExpectation = expectation(description: "Long expectation for testThatServiceCallsGetUserFailureBlock")
        
        //when
        service.getUser(with: 0, success: { users in
        }) { error in
            testExpectation.fulfill()
        }
        
        //then
        waitForExpectations(timeout: 1) { error in
            XCTAssertEqual(self.mockNetworkClient.sendCallCount, 1)
            XCTAssertEqual(self.mockUserMapper.mapUserCallCount, 1)
            XCTAssertEqual(self.mockRequestFactory.getUserRequestCallCount, 1)
        }
    }
}
