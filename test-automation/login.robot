*** Settings ***
Documentation                                      Login user test
Library                                            Selenium2Library
Test Timeout                                       1 minute

*** Variables ***
${url}                                              http://localhost:3000/
${url_login}                                        http://localhost:3000/login
${browser}                                          chrome
${nav_login_button}                                 xpath=//*[@data-test="nav-login"]
${login_button}                                     xpath=//*[@data-test="login-submit"]
${email_input}                                      xpath=//*[@data-test="login-email"]
${password_input}                                   xpath=//*[@data-test="login-password"]

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
User can do a login
    [Documentation]                                 The user can do a login
    Open Website
    Maximize Browser Window
    Wait Until Element Is Visible                   ${nav_login_button}
    click element                                   ${nav_login_button}
    Wait Until Element Is Visible                   ${login_button}
    Input text                                      ${email_input}        fake_email@test.com
    Input text                                      ${password_input}     qwert123
    sleep     2s
    click element                                   ${login_button}
    ${current}=    Get Location
    Should be equal  ${current}    ${URL}
    sleep     2s
    Close Browser

Email is invalid
    [Documentation]                                 The email was invalid
    Open Website
    Maximize Browser Window
    Wait Until Element Is Visible                   ${nav_login_button}
    click element                                   ${nav_login_button}
    Wait Until Element Is Visible                   ${login_button}
    Input text                                      ${email_input}        fake_email
    Input text                                      ${password_input}     qwert123
    sleep     2s
    click element                                   ${login_button}
    ${current}=    Get Location
    Should be equal  ${current}    ${url_login}
    sleep     2s
    Close Browser

Password is empty
    [Documentation]                                 The password was empty
    Open Website
    Maximize Browser Window
    Wait Until Element Is Visible                   ${nav_login_button}
    click element                                   ${nav_login_button}
    Wait Until Element Is Visible                   ${login_button}
    Input text                                      ${email_input}        fake_email@test.com    
    sleep     2s
    click element                                   ${login_button}
    ${current}=    Get Location
    Should be equal  ${current}    ${url_login}
    sleep     2s
    Close Browser