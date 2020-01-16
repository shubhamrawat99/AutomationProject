from rfpop.Page import pop_decorator
from rfpop.Page import listener
from rfpop.Page import Page
from robot.api import logger
from rfchegg.pages.CheggCom import CheggCom

from rfchegg import keywords as chegg_keywords



@pop_decorator(listener)
class CheggComMyQnAPage(Page):

    def __init__(self):
        Page.__init__(self,
                      CheggCom(),
                      chegg_keywords.build_chegg_url(part='/study/qa'))


    def verify_all_my_qna_page_questions(self, attempt, expected_questions):
        questions = []
        count = 0
        while (attempt>0):
            questions = self.bi.run_keyword("Get WebElements", "css=.my-qa-section .C-cshp-my-qa-item")
            count = len(questions)
            self.bi.run_keyword("Execute JavaScript"  ,  "window.scrollTo(0, 900)")
            self.bi.run_keyword("Sleep", '10s')
            attempt = attempt -1
        if expected_questions != count:
            raise Exception('questions are not matching on My qna page, expected '+str(expected_questions)+' , actual '+ str(count))
