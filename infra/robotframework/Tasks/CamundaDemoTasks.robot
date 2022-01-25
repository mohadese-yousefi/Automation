*** Settings ***
Resource     ..${/}resources${/}camunda_demo_resource.robot
Suite Setup  Fetch Task  ${TOPIC}

*** Tasks ***
Search with Bing
    [Tags]    search_bing
    [Setup]  Init Browser
    New page  http://www.google.com
    Go to  https://www.google.com/search?q=${VARS['search_term']}
    ${link_text}  Get text  
    ${count}=  Get Element Count  xpath=//*[contains(@class, 'tF2Cxc')]
    ${results}=  Create list
    FOR  ${index}  IN RANGE  ${count}
        ${link_text}  Get text xpath:(//*[contains(@class, 'tF2Cxc')])[${{${index} + 1}}]//a/h3
        ${href}=  Get Element Attribute
        ...  xpath:(//*[contains(@class, 'tF2Cxc')]//a/h3)[${{${index} + 1}}]
        ...  href
        Append to list  ${results}  ${href}
    END

    Set process variable  result_bing  ${link_text}

Search with DuckDuckGo
    [Tags]    search_duck
    [Setup]  Init Browser
    Go to  https://www.google.com/search?q=${VARS['search_term']}
    ${link_text}  Get text  
    ${count}=  Get Element Count  xpath=//*[contains(@class, 'tF2Cxc')]
    ${results}=  Create list
    FOR  ${index}  IN RANGE  ${count}
        ${link_text}  Get text xpath:(//*[contains(@class, 'tF2Cxc')])[${{${index} + 1}}]//a/h3
        ${href}=  Get Element Attribute
        ...  xpath:(//*[contains(@class, 'tF2Cxc')]//a/h3)[${{${index} + 1}}]
        ...  href
        Append to list  ${results}  ${href}
    END
    Set process variable  result_bing  ${link_text}


Send Search Result Email
    [Tags]    send_results
    Send results email
