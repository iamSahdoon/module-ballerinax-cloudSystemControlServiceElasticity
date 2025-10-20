// Copyright (c) 2025, WSO2.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/test;
import ballerina/io;

configurable ApiKeysConfig apiKeyConfig = ?;

final Client temenos = check new (apiKeyConfig);

@test:Config {}
isolated function testGetCustomers() returns error? {
    CustomerInformationResponse|error response = temenos->/customers.get();
    if response is CustomerInformationResponse {
        io:println("Success Response: ", response);
        test:assertTrue(true, "Successfully retrieved customer information");
    } else {
        io:println("Error Response: ", response.message());
        test:assertFail("Failed to retrieve customers: " + response.message());
    }
}

@test:Config {}
isolated function testGetCustomerDetails() returns error? {
    string customerId = "66052"; // Replace with a valid customerId from GET /customers response
    CustomerResponse|error response = temenos->/customers/[customerId].get();
    if response is CustomerResponse {
        io:println("Success Response for Customer Details: ", response);
        test:assertTrue(true, "Successfully retrieved customer details for ID: " + customerId);
    } else {
        io:println("Error Response for Customer Details: ", response.message());
        test:assertFail("Failed to retrieve customer details for ID " + customerId + ": " + response.message());
    }
}