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

*** Test Cases ***
User can do register
    [Documentation]                                 The user can register
    open browser                                    ${URL}    ${browser}
    Maximize Browser Window
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
    open browser                                    ${URL}    ${browser}
    Maximize Browser Window
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
    open browser                                    ${URL}    ${browser}
    Maximize Browser Window
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
    open browser                                    ${URL}    ${browser}
    Maximize Browser Window
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