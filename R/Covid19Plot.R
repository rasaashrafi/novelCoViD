#' @title Covid19Plot
#'
#' @description function to plot number of new cases of confirmed and death from covid19 as a function of time for a specific country in a time interval
#'
#' @param data a dataframe that contains covid19 data which can be reached by function Covid19Data(). defult is local_data which is the old version of covid19 data, that is stored in the package. some one can use this defult if he/she can't reach the net
#' @param start_date a string that indicate the beginning of the interval of date, possible formats are: "y-m-d" or "y/m/d"
#' @param end_date a string that indicate the end of the interval of date, possible formats are: "y-m-d" or "y/m/d"
#' @param country a string that indicate name of a country or a vector of strings that indicate name of some countries, possible values are:
#' ??????????????????????
#'
#' @return a plot of number of new cases of confirmed and death from covid19 as a function of time for the given country in the given time interval
#'
#' @export
#'
#' @importFrom dplyr select
#' @importFrom dplyr filter
#'
#' @importFrom tidyr gather
#'
#' @importFrom ggplot2 ggplot
#' @importFrom ggplot2 aes
#' @importFrom ggplot2 theme
#' @importFrom ggplot2 geom_line
#' @importFrom ggplot2 ggtitle
#' @importFrom ggplot2 theme_bw
#' @importFrom ggplot2 element_text
#' @importFrom ggplot2 facet_grid
#'
#' @examples
#' \dontrun{
#' newdata <- Covid19Data()
#' Covid19Plot(newdata,"Iran")
#' Covid19Plot(newdata,"Iran",start_date="2020-01-22",end_date = Sys.Date())
#' Covid19Plot(newdata,country=c("Iran","india"),start_date="2020/02/22",end_date = "2020/05/15")
#' }
Covid19Plot <- function(data = local_data,
                        country,
                        start_date="2020-01-22",
                        end_date = Sys.Date()
                        ) {
  start_date <- as.Date(start_date)
  end_date <- as.Date(end_date)
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
    #geom_point()+
    #ggplot2::ggtitle(country_name)+
    ggplot2::facet_grid(.~Country)+
    ggplot2::theme_bw()+
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, vjust = 0.5, hjust=1))
  return(plt)
}
