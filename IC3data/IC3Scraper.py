from bs4 import BeautifulSoup
import lxml
import requests
import pandas as pd

from enum import IntEnum

class TableType(IntEnum):
    VictimCount = 0,
    VictimLoss = 1,
    SubjectCount = 2,
    SubjectLoss = 3,
    VictimAgeGroup = 4


baseurl = 'https://www.ic3.gov/Media/PDF/AnnualReport/'
stateurl = 'State/StateReport.aspx#'


def ic3Scraper(year):
    # Place holder data frames
    dataVictimCount = None
    dataVictimLoss = None
    dataSubjectCount = None
    dataSubjectLoss = None
    dataVictimAgeGroup = None

    for index in range(1, 57):
        print(year, index)
        parseState(year, index)
        # break

        #stateVictimCount, stateVictimLoss, stateSubjectCount, stateSubjectLoss, stateVictimAgeGroup = parseState(year, index)
        #print(stateVictimCount)
        # print(stateVictimLoss)
        # print(stateSubjectCount)
        # print(stateSubjectLoss)
        # print(stateVictimAgeGroup)

        # if dataVictimCount is not None:
        #     print('Adding new data')
        #     dataVictimCount.append(stateVictimCount)
        # else:
        #     print('First data')
        #     dataVictimCount = stateVictimCount

        # if index == 2:
        #     print(dataVictimCount)
        #     break


def parseState(year, stateId):
    url = baseurl + year + stateurl
    print(url)
    response = requests.get(url, params = { 's': stateId })
    print(response)
    soup = BeautifulSoup(response.text, 'lxml')

    # Get State
    state = soup.find('option', selected = True).text
    print(state)

    # Victim Count
    print('Parsing Victim Count')
    dataVictimCount = parseTable(soup, TableType.VictimCount)
    filename = './scraped/{} {} IC3 Victim Count.csv'.format(year, state)
    dataVictimCount.to_csv(filename)
    # return

    # Victim Loss
    print('Parsing Victim Loss')
    dataVictimLoss = parseTable(soup, TableType.VictimLoss)
    filename = './scraped/{} {} IC3 Victim Loss.csv'.format(year, state)
    dataVictimLoss.to_csv(filename)

    # Subject Count
    print('Parsing Subject Count')
    dataSubjectCount = parseTable(soup, TableType.SubjectCount)
    filename = './scraped/{} {} IC3 Subject Count.csv'.format(year, state)
    dataSubjectCount.to_csv(filename)

    # Subject Loss
    print('Parsing Subject Loss')
    dataSubjectLoss = parseTable(soup, TableType.SubjectLoss)
    filename = './scraped/{} {} IC3 Subject Loss.csv'.format(year, state)
    dataSubjectLoss.to_csv(filename)

    # Victim Age Group
    print('Parsing Victim Age Group')
    dataVictimAgeGroup = parseTable(soup, TableType.VictimAgeGroup)
    filename = './scraped/{} {} IC3 Victim Age Group.csv'.format(year, state)
    dataVictimAgeGroup.to_csv(filename)

    #return dataVictimCount, dataVictimLoss, dataSubjectCount, dataSubjectLoss, dataVictimAgeGroup


def parseTable(soup, position):
    split = True

    match position:
        case TableType.VictimCount | TableType.VictimLoss | TableType.SubjectCount | TableType.SubjectLoss:
            # print('Regular Table')
            table = soup.find_all('table', class_ = 'crimetype')[position]
        case TableType.VictimAgeGroup:
            # print('Age Group Table')
            table = soup.find_all('div', class_ = 'age')[0]
            split = False
            # print(table)

    # Get headers
    headers = [th.text for th in table.find_all('th')]
    #print(headers)

    if len(headers) == 4:
        headers = headers[:2]
        # print(headers)

    # Setup data frame
    df = pd.DataFrame(columns = headers)

    # Get rows
    for table_row in table.find_all('tr')[1:]:
        row = table_row.find_all('td')
        row_data = [td.text for td in row]
        # print(row_data)

        if len(row_data) == 1:
            break
        else:
            index = len(df)
            if split:
                two_rows = splitRows(row_data, 2)
                df.loc[index] = two_rows[0]
                df.loc[index+1] = two_rows[1]
            else:
                df.loc[index] = row_data
    
    return df


def splitRows(input_list, columns):
    # print(input_list)
    index = 0
    result = []
    row = []

    for item in input_list:
        # print(item)
        # print('add to row')
        row.append(item)
        index += 1

        if index == columns:
            # print(row)
            result.append(row)
            row = []
            index = 0

    # print(result)
    return result


if __name__ == '__main__':
    print('main program')

    ic3Scraper('2022')
    ic3Scraper('2021')
    ic3Scraper('2020')
    ic3Scraper('2019')
    ic3Scraper('2018')
    ic3Scraper('2017')
    ic3Scraper('2016')
    
    # Test splitRows
    # data = ['state1', 'count1', 'state2', 'count2']
    # splitRows(data, 2)
