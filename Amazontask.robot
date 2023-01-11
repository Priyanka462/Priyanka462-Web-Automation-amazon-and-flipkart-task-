*** Settings ***
Documentation       Template robot main suite
...        Opening amazon website
...        Searching for products
...        Scraping the data with product details and stores into list table
...        Creating table list for text price url and Rating
...        converting table into csv files save the data into excel sheet.

Library    RPA.Browser.Selenium
Library    RPA.Tables
Library    DataScraping   
Library    Collections
Library    RPA.FileSystem
Library    RPA.Excel.Files
Library    XML

*** Variables ***
@{Headers}=    Name    Rating    Price 


*** Keywords ***
Opening Amazon Browser
    ${config}=    Parse Xml    config.xml
    ${url}=    Get Element Text    ${config}[0]    
        Open Available Browser    ${url}      maximized=True    browser_selection=Chrome
        Click Element    //*[@id="twotabsearchtextbox"]
        Input Text    //*[@id="twotabsearchtextbox"]    mobiles
        Click Element    //*[@id="nav-search-submit-button"]   
        Sleep    2s

    

DataScraping Results
    
    
    #${Check}=    Convert To Boolean    True

    ${count}=    Set Variable     2
    
    ${name}=    Get WebElements    xpath=//span[@class="a-size-medium a-color-base a-text-normal"] 
     FOR    ${element}    IN    @{name}
            ${product name}=    Get Text    ${element}
            Log To Console    ${product name}
            Open Workbook    Amazon output.xlsx
            Read Worksheet    Sheet1
            Set Cell Value    ${count}    A   ${product name}
            Save Workbook
            ${count}=    Evaluate    ${count} + 1
            
     END
         
         IF   "${product name}" != "None"
            
               ${Check}=    Convert To Boolean    True
             
         ELSE
               ${Check}=    Convert To Boolean    False
         END
    
    ${rating}=    Get WebElements    xpath=//span[@class="a-size-base"]
        FOR    ${element}    IN    @{rating}
            ${product rating}=    Get Text    ${element}
            Log To Console    ${product rating}
            Open Workbook    Amazon output.xlsx
            Read Worksheet    Sheet1
            Set Cell Value    ${count}    B   ${product rating}
            Save Workbook
            ${count}=    Evaluate    ${count} + 1
            
        END

            IF    "${product rating}" != "None"
            
                 ${Check}=    Convert To Boolean    True
             
            ELSE
                 ${Check}=    Convert To Boolean    False
            END

    ${price}=    Get WebElements   xpath=//span[@class="a-price-whole"]
    
        FOR    ${element}    IN    @{price}
            ${total price}=    Get Text    ${element}
            Log To Console    ${total price}
            Open Workbook    Amazon output.xlsx
            Read Worksheet    Sheet1
            Set Cell Value    ${count}    C   ${total price}
            Save Workbook
            ${count}=    Evaluate    ${count} + 1
        
        
        END
     
             IF    "${total price}" != "None"
            
                 ${Check}=    Convert To Boolean    True
             
            ELSE
                 ${Check}=    Convert To Boolean    False
            END
    
     


    
        

      
*** Tasks ***

DataScraping Demo
   TRY
       Opening Amazon Browser
       
   EXCEPT     Open Workbook    Amazon output.xlsx    overwrite=True
             Read Worksheet    Sheet1    
             Set Cell Value    1    A   PRODUCT NAME
             Set Cell Value    1    B   PRODUCT RATING
             Set Cell Value    1    C   PRODUCT PRICE
             Save Workbook
       
   FINALLY
           Datascraping Results
   END 

   
     
   

      

