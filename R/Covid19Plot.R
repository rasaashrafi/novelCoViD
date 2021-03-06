#' @title Covid19Plot
#'
#' @description function to plot number of daily confirmed cases and death from covid19 as a function of time for a given country in a given time interval
#'
#' @param data a dataframe that contains covid19 data which can be reached by function Covid19Data(). Default is local_data which is the offline available version of covid19 data stored in the package. Someone can use this default if he/she can't reach the net.
#' @param country a string that indicates name of a country or a vector of strings that indicates name of some countries. available names are stored in the variable named 'country_names'.
#' @param start_date a string that indicates the beginning of the interval, possible formats are: "yyyy-m-d" or "yyyy/m/d".
#' @param end_date a string that indicates the end of the interval, possible formats are: "yyyy-m-d" or "yyyy/m/d".
#'
#'
#' @return a plot of number of daily confirmed cases and death from covid19 as a function of time for the given country in the given time interval
#'
#' @export
#'
#'
#' @examples
#' \dontrun{
#' newdata <- Covid19Data()
#' Covid19Plot(newdata,"Iran")
#' Covid19Plot(newdata,"Iran",start_date="2020-01-22",end_date = Sys.Date())
#' Covid19Plot(newdata,country=c("Iran","India"),start_date="2020/02/22",end_date = "2020/05/15")
#' }
Covid19Plot <- function(data = local_data,
                        country,
                        start_date="2020-01-22",
                        end_date = Sys.Date()
                        ) {
  start_date <- as.Date(start_date)
  end_date <- as.Date(end_date)

  # check if date is in the available range or not
  if (start_date > end_date){
    check1 <- FALSE
  }else {
    check1 <- TRUE
  }

  # check if the name of countries are ok
  v <- tolower(country) %in% tolower(data$Country)
  check2 <- sum(v)==length(country)


  if (check1 & check2){
    mask <- (tolower(data$Country) %in% tolower(country)) &
      (data$Date >= start_date & data$Date <= end_date)
    df <- dplyr::filter(data, mask)
    df <- dplyr::select(df,c("Date","Country","New_Confirmed","New_Death"))
    #df <- data[mask,c("Date","Country","New_Confirmed","New_Death")]

    df2 <- tidyr::gather(df,"Type","New_Cases",-c(Date,Country))

    # title of plot
    country_name <- unique(data$Country[tolower(data$Country) %in% tolower(country)])

    plt <- ggplot2::ggplot(df2,ggplot2::aes(x=Date, y=New_Cases))+
      ggplot2::geom_line(ggplot2::aes(color=Type),size=1)+
      ggplot2::facet_wrap(.~Country)+
      #ggplot2::scale_color_manual(values = c("deeppink3","cyan3"))+
      ggplot2::theme_bw()+
      ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, vjust = 0.5, hjust=1))
  } else {
    if (check1){
      plt <- "There is a problem in the given name for countries. Check for available country names through \'country_names\'."
    } else {
      plt <- "The given start_date should be before the given end_date."
    }
  }
  return(plt)
}
