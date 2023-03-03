*** Settings ***
Documentation                                      Register user test
Library                                            Selenium2Library
Test Timeout                                       1 minute

*** Variables ***
${url}                                              http://localhost:3000/
${url_register}                                     http://localhost:3000/register
${browser}                                          chrome
${nav_register_button}                              xpath=//*[@data-test="nav-register"]
${register_button}                                  xpath=//*[@data-test="register-submit"]
${name_input}                                       xpath=//*[@data-test="register-name"]
${email_input}                                      xpath=//*[@data-test="register-email"]
${password_input}                                   xpath=//*[@data-test="register-password"]

*** Keywords ***
Open Website
    ${chrome_options}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --start-maximized
    Call Method    ${chrome_options}    add_argument    --window-size\=1920,1080
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    Open Browser    ${URl}    chrome    options=${chrome_options}

*** Settings ***
Suite Setup       Open Website

*** Test Cases ***
User can do register
    [Documentation]                                 The user can register
    Open Website
    Wait Until Element Is Visible                   ${nav_register_button}
    click element                                   ${nav_register_button}
    Wait Until Element Is Visible                   ${register_button}
    Input text                                      ${name_input}         fake_name
    Input text                                      ${email_input}        fake_email@test.com
    Input text                                      ${password_input}     qwert123
    sleep     1s
    click element                                   ${register_button}
    ${current}=    Get Location
    Should be equal  ${current}    ${URL} 	    
    sleep     1s
    Close Browser

Name is empty
    [Documentation]                                 The name is empty
    Open Website
    Wait Until Element Is Visible                   ${nav_register_button}
    click element                                   ${nav_register_button}
    Wait Until Element Is Visible                   ${register_button}
    Input text                                      ${email_input}        fake_email@test.com
    Input text                                      ${password_input}     qwert123
    sleep     1s
    click element                                   ${register_button}
    ${current}=    Get Location
    Should be equal  ${current}    ${url_register}
    sleep     1s
    Close Browser

Email is invalid
    [Documentation]                                 The email was invalid
    Open Website
    Wait Until Element Is Visible                   ${nav_register_button}
    click element                                   ${nav_register_button}
    Wait Until Element Is Visible                   ${register_button}
    Input text                                      ${name_input}         fake_name
    Input text                                      ${email_input}        fake_email
    Input text                                      ${password_input}     qwert123
    sleep     1s
    click element                                   ${register_button}
    ${current}=    Get Location
    Should be equal                                 ${current}    ${url_register}
    sleep     1s
    Close Browser

Password is empty
    [Documentation]                                 The password was empty
    Open Website
    Wait Until Element Is Visible                   ${nav_register_button}
    click element                                   ${nav_register_button}
    Wait Until Element Is Visible                   ${register_button}
    Input text                                      ${name_input}         fake_name
    Input text                                      ${email_input}        fake_email@test.com    
    sleep     1s
    click element                                   ${register_button}
    ${current}=    Get Location
    Should be equal                                 ${current}    ${url_register}
    sleep     1s
    Close Browser