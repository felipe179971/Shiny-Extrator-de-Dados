packages<-c("shiny",
            "shinycssloaders",
            "shinythemes",
            "SwimmeR",
            "shinyWidgets",
            "shinyjs",
            "formattable",
            "shinydashboard",
            "shinydashboardPlus",
            "plotly",
            "formattable",
            "dplyr",
            "leaflet")
package.check <- lapply(
  packages,
  FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
      install.packages(x, dependencies = TRUE)
      library(x, character.only = TRUE)
    }
  }
)
shinyApp(
  ui = dashboardPage(
    
    md = FALSE,
    skin = "blue",
    dashboardHeader(
      fixed = TRUE,
      title = tagList(
        span(class = "logo-lg", "Extrator de Dados"), 
        #img(src = "ShinyDashboardPlus_FINAL.svg")
      ),
      leftUi = tagList(
        dropdownBlock(
          id = "mydropdown",
          title = "Contexto",
          icon = icon("globe-americas"),
          prettyRadioButtons(
            inputId = "Id039afdfgtd1",
            label = "Variável:", 
            choices = c("Var 1", "Var 2", "Var 3"),
            selected = c("Var 1"),
            icon = icon("check"), 
            bigger = F
          )
        ),
        dropdownBlock(
          id = "mydropdown",
          title = "Linha",
          icon = icon("grip-lines"),
          prettyRadioButtons(
            inputId = "Id039afdfgtd",
            label = "Variável:", 
            choices = c("Var 1", "Var 2", "Var 3"),
            selected = c("Var 1"),
            icon = icon("check"), 
            bigger = F
          )
        ),
        dropdownBlock(
          id = "mydropdown2",
          title = "Coluna",
          icon = icon("columns"),
          prettyRadioButtons(
            inputId = "Id039afghd",
            label = "Variável:", 
            choices = c("Var 1", "Var 2", "Var 3"),
            selected = c("Var 1"),
            icon = icon("check"), 
            bigger = F
          )
        ),
        dropdownBlock(
          id = "mydropdown3",
          title = "Filtro",
          icon = icon("filter"),
          prettyRadioButtons(
            inputId = "Id039afdg",
            label = "Variável:", 
            choices = c("Var 1", "Var 2", "Var 3"),
            selected = c("Var 1"),
            icon = icon("check"), 
            bigger = T
          )
        ),
        dropdownBlock(
          id = "mydropdown3",
          title = "Métrica",
          icon = icon("bar-chart-o"),
          prettyRadioButtons(
            inputId = "Id039afdgdfads",
            label = "Variável:", 
            choices = c("Var 1", "Var 2", "Var 3"),
            selected = c("Var 1"),
            icon = icon("check"), 
            bigger = T
          )
        )
      ),
      
      #dropdownMenu(
      #  type = "tasks", 
      #  badgeStatus = "danger",
      #  taskItem(value = 20, color = "aqua", "Refactor code"),
      #  taskItem(value = 40, color = "green", "Design new layout"),
      #  taskItem(value = 60, color = "yellow", "Another task"),
      #  taskItem(value = 80, color = "red", "Write documentation")
      #),
      userOutput("user")
    ),
    #sidebar = dashboardSidebar(disable = T),
    dashboardSidebar(
      
      
      
      sidebarMenu(
        # Setting id makes input$tabs give the tabName of currently-selected tab
        id = "tabs3sfd",
        menuItem("Contexto", icon = icon("globe-americas"),
                 pickerInput(
                   inputId = "Id08412",
                   label = "Contexto", 
                   choices = c("Dimensão da ocupação do Turismo","Caracterização da ocupação formal do turismo","Caracterização da ocupação informal do turismo","Ocupação na economia"),selected = "Dimensão da ocupação do Turismo",
                   options = list(
                     `live-search` = TRUE)
                 )
        )
      ),
      hr(),
      sidebarMenu(
        # Setting id makes input$tabs give the tabName of currently-selected tab
        id = "tabs3",
        menuItem("Linha", icon = icon("grip-lines"),
                 prettyRadioButtons(
                   inputId = "Id039afghdd1",
                   label = "Variável:", 
                   choices = c("Var 1", "Var 2", "Var 3"),
                   selected = c("Var 1"),
                   icon = icon("check"), 
                   bigger = F
                 )
        )
      ),sidebarMenu(
        # Setting id makes input$tabs give the tabName of currently-selected tab
        id = "tabs3",
        menuItem("Coluna", icon = icon("columns"),
                 prettyRadioButtons(
                   inputId = "Id039afghdd",
                   label = "Variável:", 
                   choices = c("Var 1", "Var 2", "Var 3"),
                   selected = c("Var 1"),
                   icon = icon("check"), 
                   bigger = F
                 )
        )
      ),sidebarMenu(
        # Setting id makes input$tabs give the tabName of currently-selected tab
        id = "tabs3",
        menuItem("Linha", icon = icon("filter"),
                 prettyRadioButtons(
                   inputId = "Id039afghdd2",
                   label = "Variável:", 
                   choices = c("Var 1", "Var 2", "Var 3"),
                   selected = c("Var 1"),
                   icon = icon("check"), 
                   bigger = F
                 )
        )
      ),sidebarMenu(
        # Setting id makes input$tabs give the tabName of currently-selected tab
        id = "tabs3",
        menuItem("Métrica", icon = icon("bar-chart-o"),
                 prettyRadioButtons(
                   inputId = "Id039afghdd3",
                   label = "Variável:", 
                   choices = c("Var 1", "Var 2", "Var 3"),
                   selected = c("Var 1"),
                   icon = icon("check"), 
                   bigger = F
                 )
        )
      )
      #skinSelector()
    ),
    controlbar = dashboardControlbar(
      skin = "dark",
      controlbarMenu(
        controlbarItem(
          title = "Cor",
          icon = icon("desktop"),
          active = TRUE,
          skinSelector()
        )
      )
    ),
    dashboardBody(
      
      # use a bit of shinyEffects
      setShadow(class = "dropdown-menu"),
      setShadow(class = "box"),
      
      # some styling
      tags$head(
        tags$style(
          rel = "stylesheet",
          type = "text/css",
          href = "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/styles/qtcreator_dark.min.css"
        ),
        tags$script(
          src = "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/highlight.min.js"
        ),
        tags$script(
          "$(function() {
            $('.sidebar-toggle').on('click', function() {
              $('.skinSelector-widget').toggle();
            });
          });
          "
        )
      ),
      
      # controlbar = dashboardControlbar(
      #   skin = "dark",
      #   controlbarMenu(
      #     controlbarItem(
      #       title = "Tab 1",
      #       icon = icon("desktop"),
      #       active = TRUE,
      #       sliderInput(
      #         inputId = "inputsidebar1", 
      #         label = "Number of observations:",
      #         min = 0, 
      #         max = 1000, 
      #         value = 500
      #       )
      #     ),
      #     controlbarItem(
      #       icon = icon("paint-brush"),
      #       title = "Tab 2",
      #       numericInput(
      #         inputId = "inputsidebar2", 
      #         label = "Observations:", 
      #         value = 10, 
      #         min = 1, 
      #         max = 100
      #       )
      #     )
      #   )
      # ),
      dropdown(
        title = "My gradient Box",
        width = 12,
        icon = "fa fa-heart",
        gradientColor = "maroon", 
        boxToolSize = "xs", 
        closable = TRUE,
        footer = "The footer goes here. You can include anything",
        "This is a gradient box"
      ),
      box(
        up=T,
        title = "Consulta",
        closable = F,
        width = 12,
        status = "warning",
        solidHeader = T,
        collapsible = T,
        label = boxLabel(
          text = 1,
          status = "danger",
          style = "circle"
        ),
        dropdownMenu = boxDropdown(
          boxDropdownItem("Link to google", href = "http://www.google.com"),
          boxDropdownItem("item 2", href = "#"),
          dropdownDivider(),
          boxDropdownItem("item 3", href = "#", icon = icon("th"))
        ),
        tabsetPanel(id="Com_coef",
                    
                    tabPanel("Com Coeficiente",
                             fluidRow(column(4,
                                             uiOutput("Com_coenficiente"),
                                             awesomeRadio(inputId = "Com_coenficiente_antes_depois_2015",label = "Período",choices = c("Até 2015", "Após 2015"),selected = "Até 2015",inline = T,checkbox = TRUE
                                             ),
                                             
                             ),
                             column(8,
                                    uiOutput("Com_coenficiente2"),
                                    
                                    pickerInput(
                                      inputId = "Id084",
                                      label = "Contexto", 
                                      choices = c("Dimensão da ocupação do Turismo","Caracterização da ocupação formal do turismo","Caracterização da ocupação informal do turismo","Ocupação na economia"),selected = "Dimensão da ocupação do Turismo",
                                      options = list(
                                        `live-search` = TRUE)
                                    )
                             ),
                             ),
                             fluidRow(column(4,
                                             uiOutput("Com_coenficiente3"),
                                             
                                             pickerInput(
                                               inputId = "Id085",
                                               label = "Linha", 
                                               choices = c("Dimensão da ocupação do Turismo","Caracterização da ocupação formal do turismo","Caracterização da ocupação informal do turismo","Ocupação na economia"),selected = "Dimensão da ocupação do Turismo",
                                               options = list(
                                                 `live-search` = TRUE,style = "btn-primary")
                                             )
                             ),
                             column(4,
                                    uiOutput("Com_coenficiente4"),
                                    
                                    pickerInput(
                                      inputId = "Id086",
                                      label = "Coluna", 
                                      choices = c("Dimensão da ocupação do Turismo","Caracterização da ocupação formal do turismo","Caracterização da ocupação informal do turismo","Ocupação na economia"),selected = "Dimensão da ocupação do Turismo",
                                      options = list(
                                        `live-search` = TRUE,style = "btn-primary")
                                    )
                             ),
                             column(4,
                                    uiOutput("Com_coenficiente5"),
                                    
                                    pickerInput(
                                      inputId = "Id087",
                                      label = "Filtro", 
                                      choices = c("Dimensão da ocupação do Turismo","Caracterização da ocupação formal do turismo","Caracterização da ocupação informal do turismo","Ocupação na economia"),selected = "Dimensão da ocupação do Turismo",
                                      options = list(
                                        `live-search` = TRUE,style = "btn-primary",icon =c("glyphicon-cog"))
                                    )
                             )
                             
                             )
                    ),
                    tabPanel("Sem Coeficiente"
                    ),
                    tabPanel("Mapa da OSCs"
                    )
        )
        
      ),
      box(
        title = "Tabela",
        closable = TRUE,
        width = 12,
        status = "navy",
        solidHeader = FALSE,
        collapsible = TRUE,
        label = boxLabel(
          text = 1,
          status = "danger",
          style = "circle"
        ),
        dropdownMenu = boxDropdown(
          boxDropdownItem("Link to google", href = "http://www.google.com"),
          boxDropdownItem("item 2", href = "#"),
          dropdownDivider(),
          boxDropdownItem("item 3", href = "#", icon = icon("th"))
        ),
        formattableOutput("table")
      ),  
      
      box(
        title = "Gráfico",
        closable = TRUE,
        width = 12,
        status = "navy",
        solidHeader = FALSE,
        collapsible = TRUE,
        label = boxLabel(
          text = 1,
          status = "danger",
          style = "circle"
        ),
        dropdownMenu = boxDropdown(
          boxDropdownItem("Link to google", href = "http://www.google.com"),
          boxDropdownItem("item 2", href = "#"),
          dropdownDivider(),
          boxDropdownItem("item 3", href = "#", icon = icon("th"))
        ),
        sidebar = boxSidebar(
          startOpen = F,
          id = "mycardsidebar",
          sliderInput(
            "obs", 
            "Dá para colocar opções de edição aqui",
            min = 0, 
            max = 2, 
            value = 5
          )
        ),
        plotlyOutput("pie2")
      ),
      
      fluidRow(
        column(
          width = 6,
          box(
            title = "Gráficos",
            status = "navy",
            width = 12,
            plotlyOutput("pie3")
          )
        ),column(
          width = 6,
          box(
            title = "Gráfico",
            status = "navy",
            width = 12,
            plotlyOutput("pie")
          )
        )
        
      ),
      box(
        title = "Mapa",
        closable = TRUE,
        width = 12,
        status = "navy",
        solidHeader = FALSE,
        collapsible = TRUE,
        label = boxLabel(
          text = 1,
          status = "danger",
          style = "circle"
        ),
        dropdownMenu = boxDropdown(
          boxDropdownItem("Link to google", href = "http://www.google.com"),
          boxDropdownItem("item 2", href = "#"),
          dropdownDivider(),
          boxDropdownItem("item 3", href = "#", icon = icon("th"))
        ),
        leafletOutput("mymap")
      ), 
      box(
        title = "Equipe",
        closable = F,
        width = 12,
        status = "navy",
        solidHeader = T,
        collapsible = F,
        label = boxLabel(
          text = 1,
          status = "danger",
          style = "circle"
        ),
        
        userBox(
          title = userDescription(
            title = "Felipe Rocha",
            subtitle = "Estatística- UnB",
            type = 2,
            image = "https://1.bp.blogspot.com/-PqpvwFNhVCA/YGfmqaaFC5I/AAAAAAAAgS4/dckC5vtEtp0A1yqlXGVagSzmhuE-n7qdQCLcBGAsYHQ/s320/Screenshot_20210224-221449dsgf.jpg",
          ),
          status = "black",
          closable = F,
          "Graduando do Curso de Estatística - ",a("Lattes", href = "http://buscatextual.cnpq.br/buscatextual/visualizacv.do?id=K8206238U4"),a("Linkedin", href = "https://www.linkedin.com/in/250675207/"),
          footer = "Email: felipe179971@hotmail.com"
        ),
        userBox(
          title = userDescription(
            title = "Membro 2",
            subtitle = "sdfgsdfgsdfgsdfgsdfg",
            type = 2,
            image = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fvectorified.com%2Fimages%2Ffacebook-person-icon-33.jpg&f=1&nofb=1",
          ),
          status = "primary",
          #gradient = NULL,
          #background = "light-blue",
          #boxToolSize = "xl",
          "Some text here!",
          footer = "The footer here!"
        ),
        userBox(
          title = userDescription(
            title = "Membro 3",
            subtitle = "sdfgsdfgsdfgsdfgsdfg",
            type = 2,
            image = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fvectorified.com%2Fimages%2Ffacebook-person-icon-33.jpg&f=1&nofb=1",
          ),
          status = "primary",
          #gradient = NULL,
          #background = "light-blue",
          #boxToolSize = "xl",
          "Some text here!",
          footer = "The footer here!"
        ),
        userBox(
          title = userDescription(
            title = "Membro 4",
            subtitle = "sdfgsdfgsdfgsdfgsdfg",
            type = 2,
            image = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fvectorified.com%2Fimages%2Ffacebook-person-icon-33.jpg&f=1&nofb=1",
          ),
          status = "primary",
          #gradient = NULL,
          #background = "light-blue",
          #boxToolSize = "xl",
          "Some text here!",
          footer = "The footer here!"
        )
      ), 
      
      
      
      
      fluidRow(
        column(6,
               #br(),
               h4(p("Sobre")),
               h5(style="color:grey",p("Afim de possibilitar a visualização dos dados socioeconômicos do turismo, o IPEA, em 
parceria com o Ministério do Turismo (MTur) e a Companhia de Planejamento do Distrito Federal 
(Codeplan/DF), desenvolveram e criaram o SISTEMA DE INFORMAÇÕES SOBRE O MERCADO DE 
TRABALHO NO SETOR TURISMO – SIMT."),
                  p("Tendo como principal objetivo: 'Avaliar a importância socioeconômica do turismo no conjunto da economia, acompanhar a geração de 
postos de trabalho formais e informais além de mostrar o perfil da mão de obra, contribuindo com 
diagnósticos sobre o desempenho das chamadas Atividades Características do Turismo (ACTs), um conjunto 
de atividades no qual se concentra a maior parte dos gastos dos turistas.' - IPEA"),
                  p("O IPEA disponibiliza um extrator online para os dados do SIMT, neste encontramos um 
coeficiente turístico que possibilitam distinguir os serviços consumidos pela 
atividade turística daqueles utilizados pela população residente."),
                  p("Todos estes dados encontram-se disponíveis para download e visualização gráfica/tabular 
através do link (", a("clique aqui", href = "https://www.ipea.gov.br/extrator/simt.html"), ") E neste aplicativo Shiny desenvolvidos pelos aluno do curso de Estatística-UnB (2021)."
                  ))
        ),
        column(6,
               
               h4(p("Autores")),
               h5(style="color:grey",p("Felipe da Rocha Ferreira"),
                  p("Membro 2"),
                  p("Membro 3"),
                  p("Membro 4")),
               br(),
               h4(p("Orientador")),
               h5(p(style="color:grey","Carlos Wagner")),
               br(),
               h4(p("Professores")),
               h5(style="color:grey",p("Prof. Dr. Ana Nogales"),
                  p("Prof. Dr. Jhames Sampaio")),
               
        )
      ),
      fluidRow(
        h6(style="color:#BDBCBD;text-align: center",
           p("Universidade de Brasília - UnB"),
           p("Instituto de Ciências Exatas - IE"),
           p("Departamento de Estatística"),
           p("Brasília, DF - 2021"))
      ),
      h5(img(src = "http://www.marca.unb.br/img/assinatura_cor/as_comp_cor.gif", height = "30px"),
         "   ",
         img(src = "https://www.ipea.gov.br/acessooportunidades/img/logos/logoipea_azul.png", height = "30px")
         ,"   ",
         img(src = "https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2F2%2F27%2FCodeplan.png&f=1&nofb=1", height = "30px")
         ,"   ",
         img(src = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsZi0vIgjy-R-0xwh22R5SbAH3PXeBKCQaSWs47QixQRpaSTgFKXzB3TnGRQiDHiVVHQ&usqp=CAU", height = "30px")
         
      )
      
      
      
      
    ),
    title = "Extrator de Dados",
    footer = dashboardFooter(
      left = "Felipe da Rocha Ferreira",
      right = "Brasília-DF, Brasil, 2020"
    )
  ),
  server = function(input, output) {
    #   # app button
    #   output$appBtnVal <- renderText(input$myAppButton)
    #   observeEvent(input$myAppButton, {
    #     showModal(modalDialog(
    #       title = "Important message",
    #       "Thanks for clicking on me!"
    #     ))
    #   })
    #   
    #   
    #   output$distPlot <- renderPlot({
    #     hist(rnorm(input$obs))
    #   })
    
    output$pie3 <- renderPlotly({
      fig <- plot_ly()
      fig <- fig %>% add_pie(data = count(diamonds, cut), labels = ~cut, values = ~n,
                             name = "Cut", domain = list(x = c(0, 0.4), y = c(0.4, 1)))
      fig <- fig %>% add_pie(data = count(diamonds, color), labels = ~color, values = ~n,
                             name = "Color", domain = list(x = c(0.6, 1), y = c(0.4, 1)))
      fig <- fig %>% add_pie(data = count(diamonds, clarity), labels = ~clarity, values = ~n,
                             name = "Clarity", domain = list(x = c(0.25, 0.75), y = c(0, 0.6)))
      fig <- fig %>% layout(title = "Pie Charts with Subplots", showlegend = F,
                            xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                            yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
      
      fig
    })
    
    output$pie<-renderPlotly({
      USPersonalExpenditure <- data.frame("Categorie"=rownames(USPersonalExpenditure), USPersonalExpenditure)
      data <- USPersonalExpenditure[,c('Categorie', 'X1960')]
      
      fig <- plot_ly(data, labels = ~Categorie, values = ~X1960, type = 'pie')
      fig <- fig %>% layout(title = '',
                            xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                            yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
      
      fig
    })
    
    
    output$pie2<-renderPlotly({
      month <- c('January', 'February', 'March', 'April', 'May', 'June', 'July',
                 'August', 'September', 'October', 'November', 'December')
      high_2000 <- c(32.5, 37.6, 49.9, 53.0, 69.1, 75.4, 76.5, 76.6, 70.7, 60.6, 45.1, 29.3)
      low_2000 <- c(13.8, 22.3, 32.5, 37.2, 49.9, 56.1, 57.7, 58.3, 51.2, 42.8, 31.6, 15.9)
      high_2007 <- c(36.5, 26.6, 43.6, 52.3, 71.5, 81.4, 80.5, 82.2, 76.0, 67.3, 46.1, 35.0)
      low_2007 <- c(23.6, 14.0, 27.0, 36.8, 47.6, 57.7, 58.9, 61.2, 53.3, 48.5, 31.0, 23.6)
      high_2014 <- c(28.8, 28.5, 37.0, 56.8, 69.7, 79.7, 78.5, 77.8, 74.1, 62.6, 45.3, 39.9)
      low_2014 <- c(12.7, 14.3, 18.6, 35.5, 49.9, 58.0, 60.0, 58.6, 51.7, 45.2, 32.2, 29.1)
      
      data <- data.frame(month, high_2000, low_2000, high_2007, low_2007, high_2014, low_2014)
      
      #The default order will be alphabetized unless specified as below:
      data$month <- factor(data$month, levels = data[["month"]])
      
      fig <- plot_ly(data, x = ~month, y = ~high_2014, name = 'High 2014', type = 'scatter', mode = 'lines',
                     line = list(color = 'rgb(205, 12, 24)', width = 4)) 
      fig <- fig %>% add_trace(y = ~low_2014, name = 'Low 2014', line = list(color = 'rgb(22, 96, 167)', width = 4)) 
      fig <- fig %>% add_trace(y = ~high_2007, name = 'High 2007', line = list(color = 'rgb(205, 12, 24)', width = 4, dash = 'dash')) 
      fig <- fig %>% add_trace(y = ~low_2007, name = 'Low 2007', line = list(color = 'rgb(22, 96, 167)', width = 4, dash = 'dash')) 
      fig <- fig %>% add_trace(y = ~high_2000, name = 'High 2000', line = list(color = 'rgb(205, 12, 24)', width = 4, dash = 'dot')) 
      fig <- fig %>% add_trace(y = ~low_2000, name = 'Low 2000', line = list(color = 'rgb(22, 96, 167)', width = 4, dash = 'dot')) 
      fig <- fig %>% layout(title = "Average High and Low Temperatures in New York",
                            xaxis = list(title = "Months"),
                            yaxis = list (title = "Temperature (degrees F)"))
      
      fig
    })
    
    
    
    df <- data.frame(
      id = 1:10,
      name = c("Bob", "Ashley", "James", "David", "Jenny",
               "Hans", "Leo", "John", "Emily", "Lee"),
      age = c(28, 27, 30, 28, 29, 29, 27, 27, 31, 30),
      grade = c("C", "A", "A", "C", "B", "B", "B", "A", "C", "C"),
      test1_score = c(8.9, 9.5, 9.6, 8.9, 9.1, 9.3, 9.3, 9.9, 8.5, 8.6),
      test2_score = c(9.1, 9.1, 9.2, 9.1, 8.9, 8.5, 9.2, 9.3, 9.1, 8.8),
      final_score = c(9, 9.3, 9.4, 9, 9, 8.9, 9.25, 9.6, 8.8, 8.7),
      registered = c(TRUE, FALSE, TRUE, FALSE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE),
      stringsAsFactors = FALSE)
    output$table <- renderFormattable({
      detach("package:plotly", unload=TRUE)
      formattable(df, list(
        age = color_tile("white", "orange"),
        grade = formatter("span", style = x ~ ifelse(x == "A",
                                                     style(color = "green", font.weight = "bold"), NA)),
        area(col = c(test1_score, test2_score)) ~ normalize_bar("pink", 0.2),
        final_score = formatter("span",
                                style = x ~ style(color = ifelse(rank(-x) <= 3, "green", "gray")),
                                x ~ sprintf("%.2f (rank: %02d)", x, rank(-x))),
        registered = formatter("span",
                               style = x ~ style(color = ifelse(x, "green", "red")),
                               x ~ icontext(ifelse(x, "ok", "remove"), ifelse(x, "Yes", "No")))
      ))
    })
    
    points <- eventReactive(input$recalc, {
      cbind(rnorm(40) * 2 + 13, rnorm(40) + 48)
    }, ignoreNULL = FALSE)
    
    output$mymap <- renderLeaflet({
      leaflet() %>%
        addProviderTiles(providers$Stamen.TonerLite,
                         options = providerTileOptions(noWrap = TRUE)
        ) %>%
        addMarkers(data = points())
    })
    
    output$user <- renderUser({
      dashboardUser(
        name = "Extrator de Dados", 
        image = "https://comotrabalhar.org/wp-content/uploads/2016/02/trabalhar-na-UnB.png", 
        title = "IPEA",
        subtitle = "Author", 
        footer = p("Brasília-DF, Brasil - 2020", class = "text-center"),
        fluidRow(
          dashboardUserItem(
            width = 12,
            descriptionBlock(
              number = "Info", 
              numberColor = "green", 
              numberIcon = icon("info-circle"),
              header = "Info", 
              text = "FALAR SOBRE O EXTRATOR", 
              rightBorder = TRUE,
              marginBottom = FALSE
            ))))})
    
    #   
  }
)

