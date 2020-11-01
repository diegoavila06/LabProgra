import requests
from bs4 import BeautifulSoup
 
def nuevoleon():
    soup = get_soup("http://transparencia.nl.gob.mx/site/view?dep=SU5TVElUVVRPIEVTVEFUQUwgREUgTEFTIE1VSkVSRVM%3D&ma=T2N0dWJyZS0yMDIw&mr=T2N0dWJyZS0yMDIw&tr=MTkz&formato=ZGlyZWN0b3Jpbw%3D%3D")
    tr= soup.table.find_all('tr')
    for row in tr:
        cols = row.find_all('td')
        t = [ele.text.strip() for ele in cols]
        print(f"{t}")

 if __name__ == '__main__':
    nuevoleon()


