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

*** Test Cases ***
User can do a login
    [Documentation]                                 The user can do a login
    open browser                                    ${URL}    ${browser}
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
    open browser                                    ${URL}    ${browser}
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
    open browser                                    ${URL}    ${browser}
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