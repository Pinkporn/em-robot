*** Settings ***
Documentation     Report Templates Page
Resource          FormUtility.resource

*** Variables ***


*** Keywords ***
Go To Report Templates
    VAR    ${navlink input}    //div[contains(@class, 'mantine-Flex-root')]/a[5]
    Click Element    ${navlink input}
    Wait Until Element Is Not Visible    //div[contains(@class, 'styles_loadingOverlayContent')]
    Wait Until Element Is Not Visible    //td//span[contains(@class, 'mantine-Loader-root')]

Go To Report Templates By Url
    [Arguments]    ${url}    ${org code}    ${filter org id}=${None}
    VAR    ${url to go}    ${url}/${org code}/report/templates
    IF  $filter_org_id != ${None}
        VAR    ${url to go}    ${url to go}?organizationIds=${filter org id}
    END
    Go To    ${url to go}
    Wait Until Element Is Not Visible    //div[contains(@class, 'loadingOverlayContent')]
    Wait Until Element Is Not Visible    //td//span[contains(@class, 'mantine-Loader-root')]

Add Report Template
    [Arguments]
    ...    ${report org}
    ...    ${include org}
    ...    ${report name}
    ...    ${from period}=${None}    ${to period}=${None}
    ...    ${from base period}=${None}    ${to base period}=${None}

    Wait Until Element Is Visible    //button[.//span[text()='Report Template']]
    Click Button    //button[.//span[text()='Report Template']]
    Wait Until Element Is Visible    //section//button[.//span[text()='Next']]
    
    Select Drop Down    Reporting Organization    ${report org}
    ${input}    Get Element From Label    Organizations To Be Included In Report
    MultiSelect Drop Down By Locator    ${input}    @{include org}

    Click Button    //section//button[.//span[text()='Next']]
    
    Enter Report Details    ${None}
    ...    ${report name}
    ...    ${from period}    ${to period}
    ...    ${from base period}    ${to base period}
    
    Click Button    //section//button[.//span[text()='Create Report']]
    Wait Until Element Is Visible    //input[@placeholder="Select Organizations To Be Included In Report"]/preceding-sibling::*
    Wait Until Element Is Visible    name:detail.creatorName
    Wait For Condition
    ...    return document.getElementsByName('detail.creatorName')[0].value != ''
    ...    error=Creator Name field still blank after waiting

Enter Report Details
    [Arguments]
    ...    ${include org}=${None}
    ...    ${report name}=${None}
    ...    ${from period}=${None}    ${to period}=${None}
    ...    ${from base period}=${None}    ${to base period}=${None}
    
    IF  $include_org is not None
        ${input}    Get Element From Label    Organizations To Be Included In Report
        MultiSelect Drop Down By Locator    ${input}    @{include org}
    END

    IF  $report_name
        Input Text    //input[@name="name"]    ${report name}
    END
    IF  $to_period is None
        VAR    ${to period}    ${from period}
    END
    IF  $to_base_period is None
        VAR    ${to base period}    ${from base period}
    END
    IF  $from_period is not None
        ${input}    Get Element From Label    Report Period
        Wait Until Element Is Visible    ${input}
        Click Element    ${input}
        Select Date    ${from period}
        Select Date    ${to period}
        Wait Until Element Is Not Visible    ${POPOVER_XPATH}
    END
    IF  $from_base_period is not None
        ${input}    Get Element From Label    Base Year Period
        Wait Until Element Is Visible    ${input}
        Click Element    ${input}
        Select Date    ${from base period}
        Select Date    ${to base period}
        Wait Until Element Is Not Visible    ${POPOVER_XPATH}
    END

Enter FR-01
    [Arguments]
    ...    ${creator}=${None}    ${report date}=${None}
    ...    ${reporting period yield}=${None}    ${reporting period amount}=${None}
    ...    ${base year amount}=${None}

    IF  $creator is not None
        Input Text    name:detail.creatorName    ${creator}
    END
    IF  $report_date is not None
        ${input}    Get Element From Label    Report Date
        Scroll Element Into View    ${input}
        Click Element    ${input}
        Select Exact Date    ${report date}
        Wait Until Element Is Not Visible    ${POPOVER_XPATH}
    END
    IF  $reporting_period_yield is not None
        Select Drop Down    Yield of Reporting Period    ${reporting period yield}
    END
    IF  $reporting_period_amount is not None
        Input Text    name:detail.reportingYearProductAmount    ${reporting period amount}
    END
    IF  $base_year_amount is not None
        ${element}    Find WebElement    name:detail.baseYearProductAmount
        IF  $element is not None
            Input Text    ${element}    ${base year amount}
        END
    END

Click Go Back To List Report
    Click Element    //a[contains(@href, "report")]/button
    Wait Until Element Is Not Visible    //div[contains(@class, 'loadingOverlayContent')]
    Wait Until Element Is Not Visible    //td//span[contains(@class, 'mantine-Loader-root')]

Click Edit Report
    Click Kebab Button In Table
    Click Menu Button    Edit
    Wait Until Element Is Visible    //input[@placeholder="Select Organizations To Be Included In Report"]/preceding-sibling::*
    Wait Until Element Is Visible    name:detail.creatorName
    Wait For Condition
    ...    return document.getElementsByName('detail.creatorName')[0].value != ''
    ...    error=Creator Name field still blank after waiting

Click Export Report
    Click Kebab Button In Table
    Click Menu Button    Export
    Wait Until Page Contains    Template exported successfully    10s

Click Delete Report
    Click Kebab Button In Table
    Click Menu Button    Delete
    Wait Until Element Is Visible    //button[.='Delete']
    Click Element    //button[.='Delete']
    Wait Until Page Contains    Template deleted successfully
    
Click Save Report
    Click Element    //button[.='Save']
    Wait Until Page Contains    The report template was successfully saved

Click Save & Report
    Click Element    //button[.='Save & Export']
    Wait Until Page Contains    The report template was successfully saved
    Wait Until Page Contains    Template exported successfully    10s
    Click Go Back To List Report


