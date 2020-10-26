#' @title Covid19onMap
#'
#' @description function to show number of new cases of confirmed or death from covid19 of every country on the world map on a specific date
#'
#' @param data a dataframe that contains covid19 data which can be reached by function Covid19Data(). defult is local_data which is the old version of covid19 data, that is stored in the package. some one can use this defult if he/she can't reach the net
#' @param date a string that indicate a date, possible formats are: "y-m-d" or "y/m/d"
#' @param type a string that indicate type of reported cases, possible values are: "confirmed" and "death"
#'
#' @return a world map that the color of every country shows number of new cases of confirmed or death from covid19 on the given date
#'
#' @export
#'
#' @importFrom dplyr filter
#' @importFrom dplyr select
#' @importFrom dplyr inner_join
#' @importFrom dplyr rename
#'
#' @importFrom ggplot2 map_data
#' @importFrom ggplot2 ggplot
#' @importFrom ggplot2 geom_polygon
#' @importFrom ggplot2 aes
#' @importFrom ggplot2 coord_fixed
#' @importFrom ggplot2 scale_fill_viridis_c
#' @importFrom ggplot2 theme
#' @importFrom ggplot2 element_blank
#'
#' @examples
#' \dontrun{
#' newdata <- Covid19Data()
#' Covid19onMap(newdata, "2020-05-24", "confirmed")
#' Covid19onMap(newdata, "2020/05/24", "death")
#' }
Covid19onMap <- function(data = local_data, date, type){
  date <- as.Date(date)
  data <- dplyr::filter(data,Date==date)

  if (type=="confirmed"){
    data <- dplyr::select(data,-c("Total_Death","New_Death","Total_Confirmed"))
    data <- dplyr::rename(data, New_Cases=New_Confirmed)
  } else if (type=="death"){
    data <- dplyr::select(data,-c("Total_Confirmed","New_Confirmed","Total_Death"))
    data <- dplyr::rename(data, New_Cases=New_Death)
  }

  world <- ggplot2::map_data("world")
  world <- dplyr::rename(world, Country=region)
  data <- dplyr::inner_join(data, world, by='Country')
  #return(data)

  # ggplot(data = death3) +
  #   geom_polygon(aes(x = long, y = lat, group = group, fill = New_Cases/population2)) +
  #   coord_fixed(1.3)+
  #   scale_fill_viridis_c(option = "C")+
  #   theme(axis.line=element_blank(),axis.text.x=element_blank(),
  #         axis.text.y=element_blank(),axis.ticks=element_blank(),
  #         axis.title.x=element_blank(),
  #         axis.title.y=element_blank())

  # show new cases on the world map
  world_plot <- ggplot2::ggplot(data = data) +
    ggplot2::geom_polygon(ggplot2::aes(x = long, y = lat, group = group, fill = New_Cases)) +
    ggplot2::coord_fixed(1.3)+
    ggplot2::scale_fill_viridis_c(option = "C")+
    ggplot2::theme(axis.line=ggplot2::element_blank(),axis.text.x=ggplot2::element_blank(),
          axis.text.y=ggplot2::element_blank(),axis.ticks=ggplot2::element_blank(),
          axis.title.x=ggplot2::element_blank(),
          axis.title.y=ggplot2::element_blank())

  return(world_plot)

}
