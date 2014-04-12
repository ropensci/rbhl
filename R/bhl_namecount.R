#' Return the number of unique names found on pages in BHL. 
#' 
#' Names both with and without NameBank identifiers are counted.
#' 
#' BEWARE: this API call can take a long time. They are likely working on speeding up the
#' service, but slow for now.
#'
#' @import httr
#' @importFrom plyr compact
#' @importFrom XML xmlTreeParse
#' @param startdate start date of range between which to count names (optional)
#' @param enddate end date of range between which to count names (optional)
#' @template all
#' @export
#' @examples \dontrun{
#' bhl_namecount(startdate = '12/25/2009', enddate = '12/27/2009')
#' bhl_namecount(startdate = '10/15/2009', enddate = '10/17/2009', output='raw')
#' bhl_namecount(startdate = '10/15/2009', enddate = '10/17/2009', format='xml', output='raw')
#' bhl_namecount(startdate = '10/15/2009', enddate = '10/17/2009', format='xml', output='parsed')
#' }

bhl_namecount <- function(startdate = NULL, enddate = NULL, format='json', output = 'list', 
  key = NULL, callopts = list()) 
{
  if(output=='list') format='json'
  key <- getkey(key)
  url = "http://www.biodiversitylibrary.org/api2/httpquery.ashx"
  args <- compact(list(op = "NameCount", apikey = key, format = format,
                       startdate=startdate, enddate=enddate))
  out <- GET(url, query = args, callopts)
  stop_for_status(out)
  tt <- content(out, as="text")
  return_results(tt, output, format)
}