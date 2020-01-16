*** Settings ***
Documentation    Verifies hwh.search.for.tbs.feature (search for tbs on Chegg Study page)
Resource         resources.robot
Library          Selenium2LibraryExtended
Test Teardown    Close All Browsers

*** Variables ***
${VALID_ISBN}       9780321645852
${VALID_ISBN_TITLE}      Thinking Mathematically
${INVALID_ISBN}     @@
${ERROR_MSG}        We can't find any textbook solutions for @@. Please double check the ISBN or the spelling.
*** Test Cases ***
Search for textbook solution by ISBN on cs home page
    [Tags]    smoke     regression      STUDY-14670     testRailCaseId-C226294
    open main page
    open study page
    #comment added
    search on study home page   ${VALID_ISBN}
    select any tb suggestion from search result    1
    verify textbook selection      ${VALID_ISBN_TITLE}


Verify for a wrong search text like '@@', there should be appropriate error message
	[Tags]    smoke     regression      STUDY-14931     testRailCaseId-C226300
    open main page
    open study page
    search on study home page   ${INVALID_ISBN}
    verify errormsg for an invalid text     ${ERROR_MSG}

Verify that there should be only one suggestion for a valid isbn
	[Tags]    smoke     regression      STUDY-14931     testRailCaseId-C226301
    open main page
    open study page
    search on study home page  ${valid_isbn}
    verify number of tb suggestions     1

Verify that there should be multiple suggestions for possible search text like "science"
	[Tags]    smoke     regression      STUDY-14931     testRailCaseId-C226303
    open main page
    open study page
    search on study home page  science
    verify number of tb suggestions     1   Yes

Verify that there should be drop down showing Textbook soln,Expert Q&A, Find an online Tutor
	[Tags]    smoke     regression      STUDY-14931     testRailCaseId-C226312
	open main page
	open study page
	search on study home page  ${VALID_ISBN_TITLE}
	verify number of tb suggestions     1   Yes
	verify expert qna   1   Yes
	verify link for online tutor

Verify searching for text book by textbookname returns tbs search result
	[Tags]    smoke     regression      STUDY-14931     testRailCaseId-C226313
    open main page
    open study page
    search on study home page  ${VALID_ISBN_TITLE}
    verify number of tb suggestions     1   Yes





