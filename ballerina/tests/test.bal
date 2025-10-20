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
configurable string serviceUrl = "https://api.temenos.com/api/v1.1.0/system";


ConnectionConfig config = {
    auth: apiKeyConfig
};

final Client temenos = check new Client(config, serviceUrl);

@test:Config {
    groups: ["get_test1"]
}
isolated function testGetNumberofElasticityAgents() returns error? {
    AgentElasticCheckResponse|error response = temenos->/metrics/elasticity/agents/itemCount.get();
    if response is AgentElasticCheckResponse {
        io:println("Success Response: ", response);
        test:assertTrue(response is AgentElasticCheckResponse, "Response failed");
        test:assertTrue(response.header?.status == "success", "Response status is not success");
    } else {
        io:println("Error Response: ", response.message());
        test:assertFail("Failed to get number of elasticity agents");
    }
}

@test:Config {
    groups: ["get_test2"]
}
isolated function testGetElasticityAgents() returns error? {
    AgentElasticCheckDetailsResponse|error response = temenos->/services/elasticity/agents.get();
    if response is AgentElasticCheckDetailsResponse {
        io:println("Success Response: ", response);
        test:assertTrue(response is AgentElasticCheckResponse, "Response failed");
        test:assertTrue(response.header?.status == "success", "Response status is not success");
    } else {
        io:println("Error Response: ", response.message());
        test:assertFail("Failed to get elasticity agents");
    }
}




