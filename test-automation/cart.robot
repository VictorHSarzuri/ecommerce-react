*** Settings ***
Documentation                                      Cart test
Library                                            Selenium2Library
Test Timeout                                       1 minute

*** Variables ***
${url}                                              http://localhost:3000/
${url_cart}                                         http://localhost:3000/cart
${url_product}                                      http://localhost:3000/product
${browser}                                          chrome
${nav_cart_button}                                  xpath=//*[@data-test="nav-cart"]
${nav_product_button}                               xpath=//*[@data-test="nav-product"]
${cart_enpty}                                       xpath=//*[@data-test="cart-empty"]
${buton_add_cart}                                   xpath=//*[@data-test="btn-add-cart"]
${label_cart}                                       xpath=//*[contains(text(), 'Cart')]
${link_checkout}                                    xpath=//*[@data-test="link-checkout"]

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
User checks if the cart is empty
    [Documentation]                                 The user can check the cart    
    Open Website
    Wait Until Element Is Visible                   ${nav_cart_button}  1m
    click element                                   ${nav_cart_button}
    Wait Until Element Is Visible                   ${cart_enpty}
    sleep     1s
    ${current}=    Get Location
    Should be equal  ${current}    ${url_cart} 	    
    sleep     2s
    Close Browser

User adds a product into cart
    [Documentation]                                 The user can add a product into cart
    Open Website    
    Wait Until Element Is Visible                   ${nav_cart_button}  1m
    click element                                   ${nav_product_button}
    ${current}=    Get Location
    Should be equal  ${current}    ${url_product}
    Wait Until Element Is Visible                   ${buton_add_cart}    1m
    Wait Until Page Contains Element                ${buton_add_cart}    10s
    Scroll Element Into View                        ${buton_add_cart}
    sleep     1s
    click element                                   ${buton_add_cart}
    sleep     1s
    click element                                   ${nav_cart_button}
    Wait Until Element Is Visible                   ${label_cart}
    sleep     2s
    Close Browser

User checkouts the purchase
    [Documentation]                                 User checkouts the purchase
    Open Website    
    Wait Until Element Is Visible                   ${nav_cart_button}  1m
    click element                                   ${nav_product_button}
    ${current}=    Get Location
    Should be equal  ${current}    ${url_product}    
    Wait Until Element Is Visible                   ${buton_add_cart}    1m
    Wait Until Page Contains Element                ${buton_add_cart}    10s
    Scroll Element Into View                        ${buton_add_cart}
    sleep     1s
    click element                                   ${buton_add_cart}
    sleep     1s
    click element                                   ${nav_cart_button}
    Wait Until Element Is Visible                   ${label_cart}
    sleep     1s
    Wait Until Element Is Visible                   ${link_checkout}
    click element                                   ${link_checkout}
    sleep     2s
    Close Browser