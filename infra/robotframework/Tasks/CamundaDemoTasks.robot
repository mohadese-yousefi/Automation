*** Settings ***
Resource     ..${/}resources${/}camunda_demo_resource.robot
Suite Setup  Fetch Task  ${TOPIC}

*** Tasks ***
Search with Bing
    [Tags]    search_bing
    [Setup]  Init Browser
    New page  http://www.google.com
    Go to  https://www.google.com/search?q=${VARS['search_term']}
    Click  xpath=//*[contains(@class, 'tF2Cxc')]
    Wait for elements state  id=results
    ${link_text}  Get text  xpath=//a/h3
    Set process variable  result_bing  ${link_text}

Search with DuckDuckGo
    [Tags]    search_duck
    [Setup]  Init Browser
    New page  http://www.google.com
    Type text  name=q  ${VARS['search_term']}  delay=50 ms
    Click  xpath=//*[contains(@class, 'tF2Cxc')]
    Wait for elements state  id=results
    ${link_text}  Get text  xpath=//a/h3
    Set process variable  result_bing  ${link_text}


Send Search Result Email
    [Tags]    send_results
    Send results email
