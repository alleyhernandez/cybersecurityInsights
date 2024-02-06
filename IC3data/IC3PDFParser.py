from pypdf import PdfReader


def PDFTableReader(document, table, page):
    '''

    '''
    reader = PdfReader(document)
    page = reader.pages[page]
    # print(page)

    lines = page.extract_text().split('\n')
    #print(lines)

    tableStart = False
    for line in lines:
        # Strip the line of whitespaces left and right
        # The line comes back with unnecessary whitespace
        line = line.strip()
        if (line == table):
            tableStart = True
        elif (tableStart):
            if (len(line) == 0):
                # End of the table, stop processing
                #print("end of table")
                break
            else:
                print(line)
                # The table will come out with two headers if more than two columns

                # The first line that is very long will have the value set in a different line
                # Need to handle this.
        else:
            # Do nothing, just skip the line
            #print("not the table start")
            pass


if __name__ == '__main__':
    # document = r'../IC3 Data/Yearly/2022_IC3Report.pdf'
    # document = r'../IC3 Data/Yearly/2021_IC3Report.pdf'
    # document = r'../IC3 Data/Yearly/2020_IC3Report.pdf'
    # document = r'../IC3 Data/Yearly/2019_IC3Report.pdf'
    # document = r'../IC3 Data/Yearly/2018_IC3Report.pdf'
    # document = r'../IC3 Data/Yearly/2017_IC3Report.pdf'
    # document = r'../IC3 Data/Yearly/2016_IC3Report.pdf'
    document = r'../IC3 Data/Yearly/2015_IC3Report.pdf'
    # document = r'../IC3 Data/Yearly/2014_IC3Report.pdf'
    # document = r'../IC3 Data/Yearly/2013_IC3Report.pdf'
    # document = r'../IC3 Data/Yearly/2012_IC3Report.pdf'
    # document = r'../IC3 Data/Yearly/2011_IC3Report.pdf'
    # document = r'../IC3 Data/Yearly/2010_IC3Report.pdf'
    # document = r'../IC3 Data/Yearly/2009_IC3Report.pdf'
    # document = r'../IC3 Data/Yearly/2008_IC3Report.pdf'
    # document = r'../IC3 Data/Yearly/2007_IC3Report.pdf'
    # document = r'../IC3 Data/Yearly/2006_IC3Report.pdf'

    table = 'By Victim Count'
    page = 16

    table = 'By Victim Loss'
    page = 17

    #table = 'Victim per State *'
    #page = 24

    #table = 'Total Victim Losses by State *'
    #page = 25
    PDFTableReader(document, table, page)
