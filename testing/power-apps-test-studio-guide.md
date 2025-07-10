# Power Apps Test Studio Guide

<!--
   Copyright 2025 Kyle J. Coder

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
-->

## Overview

Power Apps Test Studio provides automated testing capabilities for canvas applications. This guide outlines how to implement comprehensive testing for the Employee Recognition application.

## Getting Started with Test Studio

### Enabling Test Studio
1. Open Power Apps Studio
2. Go to **Advanced tools** > **Open tests**
3. Test Studio opens in a new browser tab
4. Create your first test suite

### Test Studio Interface
- **Test Explorer**: Manage test suites and cases
- **Test Recorder**: Record user interactions
- **Test Editor**: Edit recorded tests and add assertions
- **Test Runner**: Execute tests and view results

## Test Suite Structure

### Recommended Test Organization
```
Employee Recognition App Tests/
├── Smoke Tests/
│   ├── App Loads Successfully
│   ├── User Authentication
│   └── Basic Navigation
├── Award Submission Tests/
│   ├── HRO Award Submission
│   ├── Starfish Award Submission
│   ├── Hines Hero Award Submission
│   └── I-CARE Award Submission
├── Validation Tests/
│   ├── Required Field Validation
│   ├── Email Format Validation
│   └── Character Limit Validation
├── User Role Tests/
│   ├── Standard User Access
│   ├── Manager Functions
│   └── Admin Functions
└── Edge Case Tests/
    ├── Network Interruption
    ├── Large Data Sets
    └── Concurrent Users
```

## Recording Tests

### Basic Test Recording
1. **Start Recording**: Click "New test case" in Test Studio
2. **Perform Actions**: Navigate through the app performing user actions
3. **Add Assertions**: Verify expected behavior at key points
4. **Stop Recording**: Save the test case with descriptive name

### Best Practices for Recording
- **Start from App Launch**: Begin each test from app startup
- **Use Descriptive Names**: Name tests clearly (e.g., "Submit_HRO_Award_Happy_Path")
- **Add Verification Steps**: Include assertions to validate expected outcomes
- **Keep Tests Focused**: Each test should validate one specific scenario
- **Use Wait Functions**: Add waits for dynamic content loading

## Sample Test Cases

### Test Case 1: Successful HRO Award Submission
```javascript
// Test: Submit HRO Award with All Required Fields
Test("Submit_HRO_Award_Complete", function() {
    // Navigate to HRO Award form
    Click(btnHROAward);

    // Verify form loads
    Assert(IsVisible(frmHROAward), "HRO Award form should be visible");

    // Fill required fields
    SetProperty(txtNomineeName, Text, "John Doe");
    SetProperty(txtNomineeEmail, Text, "john.doe@va.gov");
    SetProperty(txtContext, Text, "Patient safety improvement initiative");
    SetProperty(txtActions, Text, "Implemented new safety protocols");
    SetProperty(txtResults, Text, "Reduced incidents by 25%");

    // Submit form
    Click(btnSubmit);

    // Verify success message
    Assert(IsVisible(lblSuccessMessage), "Success message should appear");
    Assert(lblSuccessMessage.Text = "Nomination submitted successfully",
           "Success message should confirm submission");

    // Verify navigation to home screen
    Wait(2000); // Wait for navigation
    Assert(IsVisible(scrHome), "Should return to home screen");
});
```

### Test Case 2: Required Field Validation
```javascript
// Test: Verify Required Field Validation on Starfish Award
Test("Starfish_Award_Required_Field_Validation", function() {
    // Navigate to Starfish Award form
    Click(btnStarfishAward);

    // Attempt to submit without required fields
    Click(btnSubmit);

    // Verify validation messages appear
    Assert(IsVisible(lblNomineeNameError), "Nominee name error should be visible");
    Assert(IsVisible(lblNomineeEmailError), "Nominee email error should be visible");

    // Verify form doesn't submit
    Assert(IsVisible(frmStarfishAward), "Form should remain visible");
    Assert(!IsVisible(lblSuccessMessage), "Success message should not appear");
});
```

### Test Case 3: Email Format Validation
```javascript
// Test: Email Format Validation
Test("Email_Format_Validation", function() {
    // Navigate to any award form
    Click(btnHROAward);

    // Enter invalid email format
    SetProperty(txtNomineeEmail, Text, "invalid-email-format");

    // Trigger validation (click another field)
    Click(txtNomineeName);

    // Verify email validation error
    Assert(IsVisible(lblEmailFormatError), "Email format error should be visible");
    Assert(lblEmailFormatError.Text = "Please enter a valid email address",
           "Error message should specify email format issue");

    // Test valid email format
    SetProperty(txtNomineeEmail, Text, "valid.email@va.gov");
    Click(txtNomineeName);

    // Verify error disappears
    Assert(!IsVisible(lblEmailFormatError), "Email error should disappear with valid email");
});
```

### Test Case 4: Navigation Testing
```javascript
// Test: Application Navigation Flow
Test("App_Navigation_Flow", function() {
    // Verify home screen loads
    Assert(IsVisible(scrHome), "Home screen should be visible on app start");

    // Test navigation to each award type
    Click(btnHROAward);
    Assert(IsVisible(frmHROAward), "HRO form should open");

    Click(btnBack);
    Assert(IsVisible(scrHome), "Should return to home screen");

    Click(btnStarfishAward);
    Assert(IsVisible(frmStarfishAward), "Starfish form should open");

    Click(btnBack);
    Assert(IsVisible(scrHome), "Should return to home screen");

    // Test My Submissions navigation
    Click(btnMySubmissions);
    Assert(IsVisible(scrMySubmissions), "My Submissions screen should open");

    Click(btnHome);
    Assert(IsVisible(scrHome), "Should return to home screen");
});
```

## Advanced Testing Scenarios

### Data-Driven Tests
```javascript
// Test: Multiple Award Submissions with Different Data
TestData = [
    {name: "John Doe", email: "john.doe@va.gov", type: "HRO"},
    {name: "Jane Smith", email: "jane.smith@va.gov", type: "Starfish"},
    {name: "Bob Johnson", email: "bob.johnson@va.gov", type: "Hero"}
];

TestData.ForEach(function(testCase) {
    Test("Submit_" + testCase.type + "_Award_" + testCase.name, function() {
        // Dynamic test execution based on data
        SubmitAward(testCase.name, testCase.email, testCase.type);
        VerifySubmission(testCase.type);
    });
});
```

### Error Handling Tests
```javascript
// Test: Network Interruption Handling
Test("Network_Interruption_Handling", function() {
    // Fill out form completely
    FillHROAwardForm("Complete Test Data");

    // Simulate network disconnection (requires manual intervention)
    // Add instruction for tester to disconnect network

    // Attempt submission
    Click(btnSubmit);

    // Verify appropriate error handling
    Assert(IsVisible(lblNetworkError), "Network error message should appear");
    Assert(lblNetworkError.Text.Contains("network"), "Error should mention network issue");

    // Verify form data is preserved
    Assert(txtNomineeName.Text = "Test Nominee", "Form data should be preserved");
});
```

## Performance Testing

### Load Time Testing
```javascript
// Test: App Load Performance
Test("App_Load_Performance", function() {
    var startTime = Now();

    // App should load within acceptable time
    WaitForVisible(scrHome, 5000);

    var loadTime = DateDiff(startTime, Now(), Milliseconds);

    // Assert load time is under 3 seconds
    Assert(loadTime < 3000, "App should load in under 3 seconds, actual: " + loadTime);
});
```

### Large Dataset Testing
```javascript
// Test: Performance with Large Number of Submissions
Test("Large_Dataset_Performance", function() {
    // Navigate to My Submissions with large dataset
    Click(btnMySubmissions);

    var startTime = Now();
    WaitForVisible(galSubmissions, 10000);
    var loadTime = DateDiff(startTime, Now(), Milliseconds);

    // Verify reasonable load time even with large datasets
    Assert(loadTime < 5000, "Submissions should load in under 5 seconds");

    // Verify pagination or filtering works
    Assert(galSubmissions.AllItems.Count <= 50, "Should limit displayed items for performance");
});
```

## Test Data Management

### Test Data Setup
```javascript
// Function: Create Test Data
function CreateTestData() {
    // Clear existing test data
    ClearCollection(colTestNominations);

    // Create sample test nominations
    Collect(colTestNominations,
        {
            NomineeName: "Test User 1",
            NomineeEmail: "test1@va.gov",
            AwardType: "HRO",
            Status: "Submitted"
        },
        {
            NomineeName: "Test User 2",
            NomineeEmail: "test2@va.gov",
            AwardType: "Starfish",
            Status: "Approved"
        }
    );
}
```

### Test Data Cleanup
```javascript
// Function: Clean Up Test Data
function CleanupTestData() {
    // Remove test submissions from SharePoint
    ForAll(
        Filter(Employee_Nominations, NomineeEmail in ["test1@va.gov", "test2@va.gov"]),
        Remove(Employee_Nominations, ThisRecord)
    );

    // Clear local collections
    Clear(colTestNominations);
}
```

## Continuous Integration

### Automated Test Execution
```yaml
# Azure DevOps Pipeline Integration
trigger:
  branches:
    include:
    - main
    - develop

pool:
  vmImage: 'windows-latest'

steps:
- task: PowerPlatformToolInstaller@0
  displayName: 'Install Power Platform Tools'

- task: PowerPlatformRunTests@0
  displayName: 'Run Power Apps Tests'
  inputs:
    authenticationType: 'PowerPlatformSPN'
    PowerPlatformSPN: $(PowerPlatformConnection)
    Environment: $(TestEnvironmentUrl)
    TestSuite: 'Employee Recognition Test Suite'
    OutputDirectory: '$(Agent.TempDirectory)\TestResults'

- task: PublishTestResults@2
  displayName: 'Publish Test Results'
  inputs:
    testResultsFormat: 'JUnit'
    testResultsFiles: '$(Agent.TempDirectory)\TestResults\*.xml'
```

## Test Reporting

### Test Results Analysis
- **Pass/Fail Rates**: Track test success rates over time
- **Performance Metrics**: Monitor app performance trends
- **Coverage Reports**: Ensure all critical paths are tested
- **Defect Correlation**: Link test failures to specific defects

### Automated Reporting
```javascript
// Generate Test Summary Report
function GenerateTestReport() {
    var report = {
        ExecutionDate: Now(),
        TotalTests: TestResults.Count,
        PassedTests: CountRows(Filter(TestResults, Status = "Passed")),
        FailedTests: CountRows(Filter(TestResults, Status = "Failed")),
        ExecutionTime: Sum(TestResults, Duration),
        Coverage: CalculateCoverage()
    };

    // Send report to stakeholders
    SendTestReport(report);
}
```

## Best Practices

### Test Design
1. **Independent Tests**: Each test should be self-contained
2. **Repeatable Tests**: Tests should produce consistent results
3. **Clear Assertions**: Verification points should be explicit
4. **Descriptive Names**: Test names should clearly indicate purpose
5. **Regular Maintenance**: Update tests as application evolves

### Test Execution
1. **Stable Environment**: Use dedicated test environment
2. **Clean Test Data**: Start with known, clean data state
3. **Regular Execution**: Run tests frequently during development
4. **Results Analysis**: Review and act on test results promptly
5. **Documentation**: Maintain clear test documentation

### Common Pitfalls
- **Flaky Tests**: Tests that randomly fail due to timing issues
- **Environment Dependencies**: Tests that only work in specific environments
- **Outdated Tests**: Tests that become obsolete as app changes
- **Insufficient Coverage**: Missing critical user scenarios
- **Poor Error Messages**: Assertions that don't clearly indicate failure reason

---

**Last Updated**: July 9, 2025
**Maintained By**: VHA Informatics Data Team
**Prerequisites**: Power Apps Test Studio license and environment access
