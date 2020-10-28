#' @title Covid19onMap
#'
#' @description function to show number of daily confirmed cases or death from covid19, on the world map on a given date
#'
#' @param data a dataframe that contains covid19 data which can be reached by function Covid19Data(). Default is local_data which is the offline available version of covid19 data stored in the package. Someone can use this default if he/she can't reach the net.
#' @param date a string that indicates a date, possible formats are: "yyyy-m-d" or "yyyy/m/d".
#' @param type a string that indicates type of reported cases, possible values are: "confirmed" and "death".
#' @param log_scale Boolean. if it is TRUE, the number of confirmed cases or death on map will be displayed in logarithmic scale. Default is FALSE.
#'
#' @return a world map that the color of every country shows number of new confirmed cases or new death from covid19 on the given date
#'
#' @export
#'
#'
#' @examples
#' \dontrun{
#' newdata <- Covid19Data()
#' Covid19onMap(newdata, "2020-05-24", "confirmed")
#' Covid19onMap(newdata, "2020/05/24", "death")
#' }
Covid19onMap <- function(data = local_data, date, type, log_scale =FALSE){
  date <- as.Date(date)

  # check if date is in the available range or not
  min_date <- min(data$Date)
  max_date <- max(data$Date)
  if (date < min_date | date > max_date){
    check <- FALSE
  }else {
    check <- TRUE
  }

  data <- dplyr::filter(data,Date==date)

  if (check){
    if (log_scale == TRUE){
      col_c <- data$New_Confirmed+1
      col_c <- ifelse(col_c < 0, 0, col_c)
      data$New_Confirmed <- log(col_c)

      col_d <- data$New_Death+1
      col_d <- ifelse(col_d < 0, 0, col_d)
      data$New_Death <- log(col_d)

      s2 <- "log scale"
    }else{
      s2 <- ""
    }

    if (type=="confirmed"){
      data <- dplyr::select(data,-c("Total_Death","New_Death","Total_Confirmed"))
      data <- dplyr::rename(data, New_Cases=New_Confirmed)
      s <- "New confirmed cases on "
    } else if (type=="death"){
      data <- dplyr::select(data,-c("Total_Confirmed","New_Confirmed","Total_Death"))
      data <- dplyr::rename(data, New_Cases=New_Death)
      s <- "New death on "
    }

    world <- ggplot2::map_data("world")
    world <- dplyr::rename(world, Country=region)
    data <- dplyr::inner_join(data, world, by='Country')


    # show new cases on the world map
    world_plot <- ggplot2::ggplot(data = data) +
      ggplot2::geom_polygon(ggplot2::aes(x = long, y = lat, group = group, fill = New_Cases)) +
      ggplot2::coord_fixed(1.3)+
      ggplot2::scale_fill_viridis_c(option = "C")+
      ggplot2::ggtitle(paste0(s,unique(data$Date)),s2)+
      ggplot2::theme(axis.line=ggplot2::element_blank(),axis.text.x=ggplot2::element_blank(),
            axis.text.y=ggplot2::element_blank(),axis.ticks=ggplot2::element_blank(),
            axis.title.x=ggplot2::element_blank(),
            axis.title.y=ggplot2::element_blank())

  } else {
    world_plot <- paste0("Date is out of range. Data is available for dates between ", min_date, " and ", max_date)
  }

  return(world_plot)

}
