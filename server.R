

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  updateSelectizeInput(session, "year", choices = unique(df$year), server = TRUE)
  updateSelectizeInput(session, "brand", choices = unique(df$brand), server = TRUE)
  
  ################################## FILTERING OF THE DATATABLE ##################################
  filtered_data = df
  data_filter = reactive({
    if(length(input$year)) {
      filtered_data = filtered_data %>% filter(., year == input$year)
    }
    if(length(input$brand)) {
      filtered_data = filtered_data %>% filter(., brand %in% input$brand)
    }
    return(filtered_data)
  })
  #################################################################################################
  
  
  ################################### OUTPUTS #####################################################
  output$table <- renderDataTable({
    datatable(data_filter(), rownames=TRUE, options = list(scrollX=T, columnDefs = list(list(visible = FALSE, targets = c(19))))) %>%
      formatStyle(input$selected,
                  background="skyblue", fontWeight='bold')
    
  })
  output$tree_ <- renderHighchart({
    treemap <- hchart(brand_count, "treemap", hcaes(x = brand, value = count, color = count, height = 1080))
    return(treemap)
  })
  output$mile_price <- renderHighchart({
    chart <- hchart(df, "scatter", hcaes(x = mileage, y = price, group = body))
    # Create 0-row data frame which will be used to store data
    # dat <- data.frame(x = numeric(0), y = numeric(0))
    # 
    # withProgress(message = 'Making plot', value = 0, {
    #   # Number of times we'll go through the loop
    #   n <- 17651
    #   
    #   for (i in 1:n) {
    #     # Each time through the loop, add another row of data. This is
    #     # a stand-in for a long-running computation.
    #     dat <- rbind(dat, data.frame(x = rnorm(1), y = rnorm(1)))
    #     
    #     # Increment the progress bar, and update the detail text.
    #     incProgress(1/n, detail = paste("Doing part", i))
    #     
    #     # Pause for 0.1 seconds to simulate a long computation.
    #     Sys.sleep(0.1)
    #   }
    # 
    #   })
    return(chart)
  })
  output$reviews <- renderHighchart({
    reviews_ <- hchart(density(na.omit(df$consumer_review)), type = "area", color = "#B71C1C", name = "Consumer Review") %>% hc_add_series(density(na.omit(df$kbb_expert_review)), area = TRUE, name = "KBB Expert Review") %>% hc_add_theme(hc_theme_db())
    return(reviews_)
  })
  output$miles <- renderHighchart({
    miles_ <- hchart(df$mileage, name = "Mileage") %>% hc_add_theme(hc_theme_db())
    return(miles_)
  })
  output$prices <- renderHighchart({
    prices_ <- hchart(df$price, name = "Price") %>% hc_add_theme(hc_theme_db())
    return(prices_)
  })
  
  output$years <- renderHighchart({
    years_ <- hchart(df$year, name = "Price") %>% hc_add_theme(hc_theme_db())
    return(years_)
  })
})