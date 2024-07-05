*** Settings ***
Documentation     Input Emission Regression Test
Resource          TestInput.resource
Suite Setup       Setup Everything
Test Teardown     Sleep    0.5

*** Variables ***


*** Keywords ***
Add & Check Fuel Emission
    [Arguments]    ${site name}    ${asset name}    ${fuel name}    ${amount}    
    ...    ${unit}=litre    ${asset type}=Machinery / Equipment    ${no emission}=${False}
    ...    ${scope 1}=${None}    ${scope 3}=${None}    ${outside of scope}=${None}
    ...    ${delete}=${True}
    
    ${id}    Get Last Running No
    Add Emission Page 1 2    ${SUB ORG}    ${site name}    Fuel
    Enter Fuel Form    asset name=${asset name}    fuel=${fuel name}
    ...    unit=${unit}    amount=${amount}    asset type=${asset type}
    Click Element    //button[.//span[text()='Save as Draft']]
    Wait Until Page Contains    Emission created successfully
    Wait Until New Running No Is Visible    ${id}
    Wait Until Page Contains Element    //td[@data-key="emissions"]/div
    Click Element    //td[@data-key="emissions"]/div
    IF  not $no_emission
        Wait Until Element Is Visible    //div[@role='dialog']
    END
    IF  $scope_1 is not None
        Element Should Be Visible    //p[text()='Scope 1: ' and text()='${scope 1}']
    END
    IF  $scope_3 is not None
        Element Should Be Visible    //p[text()='Scope 3: ' and text()='${scope 3}']
    END
    IF  $outside_of_scope is not None
        Element Should Be Visible    //p[text()='Outside of Scope: ' and text()='${outside of scope}']
    END
    IF  $delete
        Click Delete Emission
    END


*** Test Cases ***
Add Fuel 01
    [Documentation]    Site: Owned and used - Asset: Owned and used (Machinery)
    Add & Check Fuel Emission    ${SITE NAMES}[0]
    ...    asset name=M1OU       fuel name=Jet Kerosene    amount=100
    ...    scope 1=247.75 kg     scope 3=26.40 kg

Add Fuel 02
    [Documentation]    Site: Owned and used - Asset: Leased in (Machinery)
    Add & Check Fuel Emission    ${SITE NAMES}[0]
    ...    asset name=M1LI       fuel name=Jet Kerosene    amount=100
    ...    scope 1=247.75 kg     scope 3=26.40 kg

Add Fuel 03
    [Documentation]    Site: Owned and used - Asset: Leased out (Machinery)
    Add & Check Fuel Emission    ${SITE NAMES}[0]
    ...    asset name=M1LO       fuel name=Jet Kerosene    amount=100
    ...                          scope 3=247.75 kg

Add Fuel 04
    [Documentation]    Site: Leased in - Asset: Owned and used (Machinery)
    Add & Check Fuel Emission    ${SITE NAMES}[1]
    ...    asset name=M2OU       fuel name=Jet Kerosene    amount=100
    ...    scope 1=247.75 kg     scope 3=26.40 kg

Add Fuel 05
    [Documentation]    Site: Leased in - Asset: Leased in (Machinery)
    Add & Check Fuel Emission    ${SITE NAMES}[1]
    ...    asset name=M2LI       fuel name=Jet Kerosene    amount=100
    ...    scope 1=247.75 kg     scope 3=26.40 kg

Add Fuel 06
    [Documentation]    Site: Leased out - Asset: Leased out (Machinery)
    Add & Check Fuel Emission    ${SITE NAMES}[2]
    ...    asset name=M3LO       fuel name=Jet Kerosene    amount=100
    ...                          scope 3=247.75 kg

Add Fuel 07
    [Documentation]    Site: Owned and used - Asset: Owned and used (Vehicle)
    Add & Check Fuel Emission    ${SITE NAMES}[0]
    ...    asset name=V1OU       fuel name=Gasoline/Petrol (On-road vehicle)    amount=100
    ...    scope 1=227.19 kg     scope 3=30.38 kg    asset type=Vehicle

Add Fuel 08
    [Documentation]    Site: Owned and used - Asset: Owned and used (Vehicle)
    Add & Check Fuel Emission    ${SITE NAMES}[0]
    ...    asset name=V1OU       fuel name=LPG (On-road vehicle)    amount=100
    ...    scope 1=173.06 kg     scope 3=42.91 kg    asset type=Vehicle

Add Fuel 09
    [Documentation]    Site: Owned and used - Asset: Machinery, Biogenic fuel
    Add & Check Fuel Emission    ${SITE NAMES}[0]
    ...    asset name=M1OU       fuel name=FUEL WOOD    amount=100    unit=kg
    ...    scope 1=3.04 kg                              outside of scope=179.09 kg

Add Fuel 10
    [Documentation]    Site: Owned and used - Asset: Machinery, Mixed fuel
    Add & Check Fuel Emission    ${SITE NAMES}[0]
    ...    asset name=M1OU       fuel name=Gasohol 91    amount=100
    ...    scope 1=197.05 kg     scope 3=27.34 kg        outside of scope=15.20 kg

Add Fuel 11
    [Documentation]    Site: Owned and used - Asset: Vehicle, Mixed fuel
    Add & Check Fuel Emission    ${SITE NAMES}[0]
    ...    asset name=V1OU       fuel name=Diesel B7 (On-road vehicle)    amount=100
    ...    scope 1=254.88 kg     scope 3=27.62 kg        outside of scope=16.52 kg    asset type=Vehicle

Add Fuel 12
    [Documentation]    Site: Owned and used - Asset: Machinery, Natural gas
    Add & Check Fuel Emission    ${SITE NAMES}[0]
    ...    asset name=M1OU       fuel name=Natural gas    unit=scf    amount=100
    ...    scope 1=5.73 kg     scope 3=1.70 kg
    ...    delete=${False}

Dup Emission Fuel
    Click Duplicate Emission
    Click Element    //button[.//span[text()='Save as Draft']]
    Wait Until Element Is Not Visible    //section 
    Wait Until Page Contains    Emission duplicated successfully    

Edit Emisison Fuel
    Click Edit Emission
    Enter Fuel Form    publisher=IPCC    unit=TJ
    # Upload Evidences    ${CURDIR}/test.pdf
    Upload Evidences    ${EXECDIR}/evidences/test.pdf
    Click Element    //button[.//span[text()='Add']]
    Wait Until Element Is Not Visible    //section
    Wait Until Page Contains    Emission edited successfully

View Emisison Fuel
    Click View Emission
    Click Element    //button[.//span[text()='Close']]
    Wait Until Element Is Not Visible    //section