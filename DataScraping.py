
def get_result_text(result) -> str:
    try:
        return result.find_element_by_tag_name("h2").text
    except:
        return ""


#def get_result_url(result) -> str:
    #link= result.find_element_by_tag_name("a")
    #return link.get_attribute("href")


def get_result_price(result) -> str:
    try:
        return result.find_element_by_class_name("a-price-whole").text
    except:
        return ""


def get_result_rating(result) -> str:
    try:
        rating = result.find_element_by_xpath('.//div[@class="a-row a-size-small"]/span')
        return rating.get_attribute("aria-label")
    except:
        return ""

    



