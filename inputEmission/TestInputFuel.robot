*** Settings ***
Documentation     Input Emission Regression Test
Resource          TestInput.resource
Suite Setup       Setup Everything
Test Teardown     Sleep    0.5

*** Variables ***
@{ASSET NAME OU}    Machine 01-01    Machine 01-02    Machine 01-03    Vehicle 01-01
@{ASSET NAME LI}    Machine 02-01    Vehicle 02-01
@{ASSET NAME LO}    Machine 03-01    Vehicle 03-01

*** Keywords ***
Add & Check Fuel Emission
    [Arguments]    ${site name}    ${asset name}    ${fuel name}    ${amount}    
    ...    ${unit}=litre    ${asset type}=Machinery / Equipment    ${no emission}=${False}
    ...    ${scope 1}=${None}    ${scope 3}=${None}    ${outside of scope}=${None}
    ...    ${delete}=${True}
    
    Add Emission Page 1 2    ${SUB ORG}    ${site name}    Fuel
    Enter Fuel Form    asset name=${asset name}    fuel=${fuel name}
    ...    unit=${unit}    amount=${amount}    asset type=${asset type}
    Save Emission
    Check Record Emission
    ...    scope 1=${scope 1}
    ...    scope 3=${scope 3}
    ...    outside of scope=${outside of scope}
    ...    no emission=${no emission}
    IF  $delete
        Click Delete Emission
    END


*** Test Cases ***
Add Fuel 01
    [Documentation]    Site: Owned and used - Asset: Owned and used (Machinery)
    Add & Check Fuel Emission    ${SITE NAMES}[0]
    ...    asset name=${ASSET NAME OU}[0]       fuel name=Jet Kerosene    amount=100
    ...    scope 1=247.75 kg     scope 3=26.40 kg

Add Fuel 02
    [Documentation]    Site: Owned and used - Asset: Leased in (Machinery)
    Add & Check Fuel Emission    ${SITE NAMES}[0]
    ...    asset name=${ASSET NAME OU}[1]       fuel name=Jet Kerosene    amount=100
    ...    scope 1=247.75 kg     scope 3=26.40 kg

Add Fuel 03
    [Documentation]    Site: Owned and used - Asset: Leased out (Machinery)
    Add & Check Fuel Emission    ${SITE NAMES}[0]
    ...    asset name=${ASSET NAME OU}[2]       fuel name=Jet Kerosene    amount=100
    ...    scope 3=247.75 kg

Add Fuel 04
    [Documentation]    Site: Leased in - Asset: Owned and used (Machinery)
    Add & Check Fuel Emission    ${SITE NAMES}[1]
    ...    asset name=${ASSET NAME LI}[0]       fuel name=Jet Kerosene    amount=100
    ...    scope 1=247.75 kg     scope 3=26.40 kg

Add Fuel 05
    [Documentation]    Site: Leased in - Asset: Leased in (Machinery)
    Add & Check Fuel Emission    ${SITE NAMES}[1]
    ...    asset name=${ASSET NAME LI}[0]       fuel name=Jet Kerosene    amount=100
    ...    scope 1=247.75 kg     scope 3=26.40 kg

Add Fuel 06
    [Documentation]    Site: Leased out - Asset: Leased out (Machinery)
    Add & Check Fuel Emission    ${SITE NAMES}[2]
    ...    asset name=${ASSET NAME LO}[0]       fuel name=Jet Kerosene    amount=100
    ...    scope 3=247.75 kg

Add Fuel 07
    [Documentation]    Site: Owned and used - Asset: Owned and used (Vehicle)
    Add & Check Fuel Emission    ${SITE NAMES}[0]
    ...    asset name=${ASSET NAME OU}[3]       fuel name=Gasoline/Petrol (On-road vehicle)    amount=100
    ...    scope 1=227.19 kg     scope 3=30.38 kg    asset type=Vehicle

Add Fuel 08
    [Documentation]    Site: Owned and used - Asset: Owned and used (Vehicle)
    Add & Check Fuel Emission    ${SITE NAMES}[0]
    ...    asset name=${ASSET NAME OU}[3]       fuel name=LPG (On-road vehicle)    amount=100
    ...    scope 1=173.06 kg     scope 3=42.91 kg    asset type=Vehicle

Add Fuel 09
    [Documentation]    Site: Owned and used - Asset: Machinery, Biogenic fuel
    Add & Check Fuel Emission    ${SITE NAMES}[0]
    ...    asset name=${ASSET NAME OU}[0]       fuel name=FUEL WOOD    amount=100    unit=kg
    ...    scope 1=3.04 kg                              outside of scope=179.09 kg

Add Fuel 10
    [Documentation]    Site: Owned and used - Asset: Machinery, Mixed fuel
    Add & Check Fuel Emission    ${SITE NAMES}[0]
    ...    asset name=${ASSET NAME OU}[0]       fuel name=Gasohol 91    amount=100
    ...    scope 1=197.05 kg     scope 3=27.34 kg        outside of scope=15.20 kg

Add Fuel 11
    [Documentation]    Site: Owned and used - Asset: Vehicle, Mixed fuel
    Add & Check Fuel Emission    ${SITE NAMES}[0]
    ...    asset name=${ASSET NAME OU}[3]       fuel name=Diesel B7 (On-road vehicle)    amount=100
    ...    scope 1=254.88 kg     scope 3=27.62 kg        outside of scope=16.52 kg    asset type=Vehicle

Add Fuel 12
    [Documentation]    Site: Owned and used - Asset: Machinery, Natural gas
    Add & Check Fuel Emission    ${SITE NAMES}[0]
    ...    asset name=${ASSET NAME OU}[0]       fuel name=Natural gas    unit=scf    amount=100
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
    Upload Evidences    ${EXECDIR}/evidences/test.pdf
    Click Element    //button[.//span[text()='Add']]
    Wait Until Element Is Not Visible    //section
    Wait Until Page Contains    Emission edited successfully

View Emisison Fuel
    Click View Emission
    Click Element    //button[.//span[text()='Close']]
    Wait Until Element Is Not Visible    //section