
library(semantic.dashboard)
library(leaflet)

shinyUI(dashboardPage(
  dashboardHeader(),
  
  dashboardSidebar(sidebarMenu(
    menuItem(tabName = "home", text = "Home", icon = icon("home")),
    menuItem(tabName = "table", text = "Used Car Dataset", icon = icon("car")),
    menuItem(tabName = "tree", text = "Brand Breakdown", icon = icon("sitemap")),
    menuItem(tabName = "analyses", text= "Analyses", icon = icon("signal"))
  )),
  dashboardBody(
    titlePanel("Web Scraping Project"),
    tabItems(
      tabItem(tabName = "home",
              fluidRow(column(6,
                img(src='https://www.coxautoinc.com/wp-content/uploads/2017/07/brand-logo-max480x132-kelleybluebook.png')
                ),
                column(6, div(class="ui segment", "For this web scraping project, I scraped Kelley Blue Book (a popular car appraisal and car sale site) for recent used/certified used car listings.  I collected data on over 17,000 cars.   The data scraped included: manufacturing year, make and model, price, mileage, expert and customer reviews, and fuel efficiency.   I used 'Scrapy' to scrape ~760 pages.")
                       )),
              fluidRow(column(6, img(src='https://atcimages.kbb.com/scaler/544/408/hn/c/38b1ac23f9d94b88bb60889d44c0c9ea.jpg', width="75%", align="center"), column(6,img(src="https://atcimages.kbb.com/scaler/544/408/images/2018/3/3/479/242/43611778127.479242033.IM1.02.800x533_A.800x533.jpg", width ="75%", align="center"))))
              ),
      tabItem(tabName = "table",
              fluidRow(column(3, selectizeInput('year', label='Pick a Year:', choices= NULL, multiple = T)),
                       column(3, selectizeInput('brand', label='Pick a Brand:', choices= NULL, multiple = T)),
                       
                       dataTableOutput('table'))
              ),
      tabItem(tabName = "tree", fluidRow(highchartOutput('tree_'))
              ),
      tabItem(tabName = "analyses", fluidRow(highchartOutput('mile_price'))
            )
    )

    
  ),
  
  
  theme = "spacelab")
)

# #fluidRow(
# box(plotOutput("plot1", height = 250)),
# box(
#   title = "Controls",
#   sliderInput("slider", "Number of observations:", 1, 100, 50)