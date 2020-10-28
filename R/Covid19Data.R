#' @title Covid19Data
#'
#' @description function to read "live" covid19 data from Johns Hopkins University data repository.
#'
#' Note: This data is based on the information each country reported every day of it's total confirmed cases or death. Some countries on some dates reported number of it's cases less than the day before, so the new cases for them on that date will be reported negative in the data set.
#'
#' @return a dataframe with the daily worlwide data of covid19 per country, with total and new confirmed cases and  death
#'
#' @export
#'
#'
#' @examples
#' \dontrun{
#' newdata <- Covid19Data()
#' }
Covid19Data <- function(){

  data_confirmed <- read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")
  data_death <- read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv")


  clean_data <- function(df){
    df <- dplyr::select(df,-c("Province.State","Lat","Long"))
    # change the name of some countries
    country <- ifelse(df$Country.Region=="Taiwan*","Taiwan",
                      ifelse(df$Country.Region=="US","USA",
                             ifelse(df$Country.Region=="United Kingdom","UK",
                                    ifelse(df$Country.Region=="Congo (Kinshasa)","Democratic Republic of the Congo",
                                           ifelse(df$Country.Region=="Congo (Brazzaville)","Republic of Congo",
                                                  ifelse(df$Country.Region=="Korea, South","South Korea",
                                                         ifelse(df$Country.Region==" Cote d\'Ivoire","Ivory Coast",
                                                                ifelse(df$Country.Region=="Czechia","Czech Republic",
                                                                       ifelse(df$Country.Region=="North Macedonia","Macedonia",df$Country.Region)))))))))


    df <- dplyr::mutate(df,Country.Region=country)
    df <- dplyr::rename(df,Country=Country.Region)

    df2 <- tidyr::gather(df,"Date","value",-c(Country))

    # change the class of column Date from character to date
    df2$Date <- gsub("X","",df2$Date) # remove X
    df2$Date <- as.Date(df2$Date, "%m.%d.%y")

    df2 <- dplyr::summarise(dplyr::group_by(df2, Date, Country),Number=sum(value))
    df2 <- dplyr::ungroup(df2)
    return(df2)
  }


  # confirmed cases
  df_confirmed <- clean_data(data_confirmed)
  df_confirmed <- dplyr::rename(df_confirmed, Total_Confirmed=Number)
  # add column of daily cases
  grouped_confirm <- dplyr::arrange(dplyr::group_by(df_confirmed,Country),Date)
  confirmed_cases <- dplyr::mutate(grouped_confirm, New_Confirmed=Total_Confirmed - dplyr::lag(Total_Confirmed, default = 0))
  confirmed_cases <- dplyr::ungroup(confirmed_cases)

  # death cases
  df_death <- clean_data(data_death)
  df_death <- dplyr::rename(df_death, Total_Death=Number)
  # add column of daily cases
  grouped_death <- dplyr::arrange(dplyr::group_by(df_death,Country),Date)
  death_cases <- dplyr::mutate(grouped_death, New_Death=Total_Death - dplyr::lag(Total_Death, default = 0))
  death_cases <- dplyr::ungroup(death_cases)


  everyday_data <- merge(confirmed_cases, death_cases, by = c("Date","Country"))
  return(everyday_data)

}
