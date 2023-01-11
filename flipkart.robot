*** Settings ***
Documentation       Template robot main suite
...        Opening flipkart website
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
Opening Flipkart Browser

    Open Available Browser    https://www.flipkart.com/search?q=mobiles&otracker=search&otracker1=search&marketplace=FLIPKART&as-show=on&as=off&as-pos=1&as-type=HISTORY  maximized=True    browser_selection=chrome
    Sleep    2s
    
 #logging into website
    # Click Element    /html/body/div[2]/div/div/div/div/div[2]/div/form/div[1]/input
     #sleep    5s
     
     #Click Element    /html/body/div[2]/div/div/div/div/div[2]/div/form/div[3]/button
     #Sleep    5s

DataScraping Results

    ${count}=    Set Variable     2

    ${name}=    Get WebElements    xpath=//div[@class="_4rR01T"]
     FOR    ${element}    IN    @{name}
            ${product name}=    Get Text    ${element}
            Log To Console    ${product name}
            Open Workbook    Copy of LOU.xlsx
            Read Worksheet    Sheet1
            Set Cell Value    ${count}    A   ${product name}
            Save Workbook
            ${count}=    Evaluate    ${count} + 1
     END

         IF    "${product name}" != "None"
            
               ${Check}=    Convert To Boolean    True
             
         ELSE
               ${Check}=    Convert To Boolean    False
         END
    
     ${count}=    Set Variable     2
    ${rating}=    Get WebElements    xpath=//div[@class="_3LWZlK"]
        FOR    ${element}    IN    @{rating}
            ${product rating}=    Get Text    ${element}
            Log To Console    ${product rating}
            Open Workbook    Copy of LOU.xlsx
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

     ${count}=    Set Variable     2

    ${price}=    Get WebElements   xpath=//div[@class="_30jeq3 _1_WHN1"]
    
    FOR    ${element}    IN    @{price}
        ${total price}=    Get Text    ${element}
        Log To Console    ${total price}
        Open Workbook    Copy of LOU.xlsx
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
           Opening Flipkart Browser 
   EXCEPT    Open Workbook    Copy of LOU.xlsx    overwrite=True
             Read Worksheet    Sheet1    
             Set Cell Value    1    A   Product Name
             Set Cell Value    1    B   Product Rating
             Set Cell Value    1    C   Product Price
             Save Workbook
       
   FINALLY
            Datascraping Results
   END 

    
     
   

    
   
    
    
#https://www.amazon.in/s?k=mobiles&crid=3TO1931SQACQ&sprefix=mobiles%2Caps%2C367&ref=nb_sb_noss_1
