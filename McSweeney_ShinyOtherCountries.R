#Danny McSweeney
#BIO697
#Other Countries
#May 11, 2020

library(shiny)
library(tidyverse)
library(wesanderson)
library(lubridate)
library(maps)
library(mapdata)
library(viridis)
library(RColorBrewer)

## Uploading the time series data

time_series_confirmed_long <- read_csv(url("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")) %>%
  rename(Province_State = "Province/State", Country_Region = "Country/Region")  %>% 
  pivot_longer(-c(Province_State, Country_Region, Lat, Long),
               names_to = "Date", values_to = "Confirmed") 

time_series_deaths_long <- read_csv(url("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv")) %>%
  rename(Province_State = "Province/State", Country_Region = "Country/Region")  %>% 
  pivot_longer(-c(Province_State, Country_Region, Lat, Long),
               names_to = "Date", values_to = "Deaths")

time_series_recovered_long <- read_csv(url("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv")) %>%
  rename(Province_State = "Province/State", Country_Region = "Country/Region") %>% 
  pivot_longer(-c(Province_State, Country_Region, Lat, Long),
               names_to = "Date", values_to = "Recovered")

time_series_confirmed_long <- time_series_confirmed_long %>% 
  unite(Key, Province_State, Country_Region, Date, sep = ".", remove = FALSE)
time_series_deaths_long <- time_series_deaths_long %>% 
  unite(Key, Province_State, Country_Region, Date, sep = ".") %>% 
  select(Key, Deaths)
time_series_recovered_long <- time_series_recovered_long %>% 
  unite(Key, Province_State, Country_Region, Date, sep = ".") %>% 
  select(Key, Recovered)

time_series_long_joined <- full_join(time_series_confirmed_long,
                                     time_series_deaths_long, by = c("Key"))
time_series_long_joined <- full_join(time_series_long_joined,
                                     time_series_recovered_long, by = c("Key")) %>% 
  select(-Key)


#Reformatting
time_series_long_joined$Date <- mdy(time_series_long_joined$Date)


time_series_long_joined_counts <- time_series_long_joined %>% 
  pivot_longer(-c(Province_State, Country_Region, Lat, Long, Date),
               names_to = "Report_Type", values_to = "Counts")


global_time_series <- time_series_long_joined


Report_Type = c("Confirmed", "Deaths", "Recovered")


#Loading information for specific European countries
world <- map_data("world")

euro.list <- c("France","Germany","Austria","Spain","Portugal","Belgium","Switzerland","Italy","Greece","Poland")
#retrieve map data
euro.list <- map_data("world", region = euro.list)


# Create list of countries
Countries.euro <- global_time_series %>% 
  select(Country_Region) %>% 
  filter (Country_Region %in% c("France","Germany","Austria","Spain","Portugal","Belgium","Switzerland","Italy","Greece","Poland"))
#Extract data from countries
global_time_series.euro <- global_time_series %>% 
  filter (Country_Region %in% c("France","Germany","Austria","Spain","Portugal","Belgium","Switzerland","Italy","Greece","Poland"))


# Define UI for application 
ui <- fluidPage(
  
  # Application title
  titlePanel("Confirmed Cases, Recovered Cases, and Deaths for COVID-19 in Select European Countries"),
  p("This application was created using the Johns Hopkins Center CSSE database, available here:",
    tags$a("GitHub Repository", href="https://github.com/CSSEGISandData")
  ),
  tags$br(),
  tags$hr(),  # Adds line to page
  
  sidebarLayout(
    sidebarPanel(
      # Select Reporting type
      selectInput("select_type", 
                  label = "Report Type", 
                  choices = Report_Type, selected = "Confirmed"),
      # Select Date 
      sliderInput("slider_date", label = "Report Date", min = first_date, 
                  max = last_date, value = first_date, step = 7)
    ),
    
    # Show a plots
    mainPanel(
      plotOutput("covidPlot")
    )
  )
)

# Define server logic required to make the plot
server <- function(input, output) {
  
  output$covidPlot <- renderPlot({
    # develop data set to graph
    pick_date <- global_time_series.euro %>% 
      # Fix mapping to map_data of US != USA  
      #mutate(Country_Region = recode(Country_Region, US = "USA")) %>% 
      # *** This is where the slider input with the date goes
      filter(Date == input$slider_date) %>% 
      group_by(Country_Region) %>% 
      summarise_at(c("Confirmed", "Deaths", "Recovered"), sum)
    
    # We need to join the us map data with our daily report to make one data frame/tibble
    country_join <- left_join(euro.list, pick_date, by = c("region" = "Country_Region"))
    
    # plot world map
    ggplot(data = euro.list, mapping = aes(x = long, y = lat, group = group)) + 
      coord_fixed(1.5) + 
      # Add data layer
      geom_polygon(data = country_join, aes_string(fill = input$select_type), color = "black") +
      scale_fill_gradientn(colours = 
                             wes_palette("Zissou1", 100, type = "continuous"),
                           trans = "log10") +
      
      theme(
        legend.position = "bottom",
        text = element_text(color = "#22211d"),
        plot.background = element_rect(fill = "#ffffff", color = NA), 
        panel.background = element_rect(fill = "#ffffff", color = NA), 
        legend.background = element_rect(fill = "#ffffff", color = NA)
      )+
      ggtitle("COVID-19 data for ", input$select_type)
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)