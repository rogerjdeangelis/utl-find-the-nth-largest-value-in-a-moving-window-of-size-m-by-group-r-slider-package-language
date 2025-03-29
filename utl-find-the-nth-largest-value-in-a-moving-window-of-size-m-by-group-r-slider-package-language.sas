%let pgm=utl-find-the-nth-largest-value-in-a-moving-window-of-size-m-by-group-r-slider-package-language;

%stop_submission;

Find the nth largest value in a moving window of size m by group r slider and dplyr package language

   CONTENTS

      1 r slider/dplyr language
      2 related repos

github
https://tinyurl.com/yc3cxh97
https://github.com/rogerjdeangelis/utl-find-the-nth-largest-value-in-a-moving-window-of-size-m-by-group-r-slider-package-language

SOAPBOX ON

Another example why all those  r and python and package languages in are so useful.

SOAPBOX OFF

I could not get the posted solution to work?
https://tinyurl.com/2hx4d5yy
https://communities.sas.com/t5/SAS-Programming/Find-Nth-largest-within-each-group-for-moving-window/m-p/845789#M334370I

Find the nth largest value in a moving window of size m by group r dplyr language
This problem
Find the 2nd largest value in a moving window of size 3 by group r dplyr language

/**************************************************************************************************************************/
/* FIND THE 2nd LARGEST VALUE IN MOVING WINDOW OD SIZE 3                      |                                           */
/*                       |                                                    |                                           */
/*     INPUT             |      PROCESS                                       |           OUTPUT                          */
/*     =====             |      =======                                       |           ======                          */
/*                       |                                                    |                                           */
/* GROUP TIME VALUE      | 1 R SLIDER/DPLYR LANGUAGE                          |   Second largest window 3                 */
/*                       | =========================                          |                                           */
/*   A     1     1       |                                                    |                                           */
/*   A     2     4       |           MIDDLE VALUE                             |   GROUP  TIME VALUE MOVING_NTH            */
/*   A     3     5       |           WINDOW SIZE 3                            |                                           */
/*   A     4     2       | ID VALUE  2ND LARGEST                              |   A         1     1         NA            */
/*   A     5     3       |                                                    |   A         2     4         NA            */
/*                       |  1    1 NA                                         |   A         3     5          4            */
/*   B     1    50       |  1    4 NA                                         |   A         4     2          4            */
/*   B     2    20       |  1    5 4   middle of current & prev 2             |   A         5     3          3            */
/*   B     3    30       |  1    2 4   middle of current & prev 2             |   B         1    50         NA            */
/*   B     4    10       |  1    3 3   middle of current & prev 2             |   B         2    20         NA            */
/*   B     5    40       |                                                    |   B         3    30         30            */
/*                       |  2   50 NA                                         |   B         4    10         20            */
/*                       |  2   20 NA                                         |  AB         5    40         30            */
/*  options              |  2   30 30  middle of current & prev 2             |  i                                        */
/*   validvarname=upcase;|  2   10 20   middle of current & prev 2            |                                           */
/*  libname sd1 "d:/sd1";|  2   40 30   middle of current & prev 2            |  Also works for 2nd largest               */
/*  data sd1.have;       |                                                    |   n window size 5                         */
/*   input time group$   |                                                    |                                           */
/*     value;            |  %utl_rbeginx;                                     |   GROUP  TIME VALUE MOVING_NTH            */
/*  cards4;              |  parmcards4;                                       |                                           */
/*  1 A 1                |  library(dplyr)                                    |   A         1     1         NA            */
/*  2 A 4                |  library(haven)                                    |   A         2     4         NA            */
/*  3 A 5                |  library(slider)                                   |   A         3     5         NA            */
/*  4 A 2                |  source("c:/oto/fn_tosas9x.R")                     |   A         4     2         NA            */
/*  5 A 3                |  data<-read_sas("d:/sd1/have.sas7bdat")            |   A         5     3          4            */
/*  1 B 50               |  data                                              |   B         1    50         NA            */
/*  2 B 20               |  n <-2   # 2nd highest value per group             |   B         2    20         NA            */
/*  3 B 30               |  window_size <- 3  # Current + previous 2          |   B         3    30         NA            */
/*  4 B 10               |  data <- data %>%                                  |   B         4    10         NA            */
/*  5 B 40               |   group_by(GROUP) %>%                              |   B         5    40         40            */
/*  ;;;;                 |   mutate(                                          |                                           */
/*  run;quit;            |     moving_nth = slider::slide_dbl(                |                                           */
/*                       |       VALUE,                                       |                                           */
/*                       |       .f = ~ sort(., decreasing=TRUE)[n],          |                                           */
/*                       |       .before = window_size - 1,                   |                                           */
/*                       |       .complete = FALSE                            |                                           */
/*                       |     )                                              |                                           */
/*                       |   ) %>%                                            |                                           */
/*                       |    ungroup()                                       |                                           */
/*                       |  data<-data %>%                                    |                                           */
/*                       |    select(GROUP,TIME,VALUE,moving_nth)             |                                           */
/*                       |  data[data$TIME<window_size,4] <- NA               |                                           */
/*                       |  data                                              |                                           */
/*                       |  fn_tosas9x(                                       |                                           */
/*                       |        inp    = data                               |                                           */
/*                       |       ,outlib ="d:/sd1/"                           |                                           */
/*                       |       ,outdsn ="want"                              |                                           */
/*                       |       )                                            |                                           */
/*                       |  ;;;;                                              |                                           */
/*                       |  %utl_rendx;                                       |                                           */
/**************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

options
 validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.have;
 input time group$
   value;
cards4;
1 A 1
2 A 4
3 A 5
4 A 2
5 A 3
1 B 50
2 B 20
3 B 30
4 B 10
5 B 40
;;;;
run;quit;

/**************************************************************************************************************************/
/*  GROUP TIME VALUE                                                                                                      */
/*                                                                                                                        */
/*    A     1     1                                                                                                       */
/*    A     2     4                                                                                                       */
/*    A     3     5                                                                                                       */
/*    A     4     2                                                                                                       */
/*    A     5     3                                                                                                       */
/*                                                                                                                        */
/*    B     1    50                                                                                                       */
/*    B     2    20                                                                                                       */
/*    B     3    30                                                                                                       */
/*    B     4    10                                                                                                       */
/*    B     5    40                                                                                                       */
/**************************************************************************************************************************/

/*              _ _     _
/ |  _ __   ___| (_) __| | ___ _ __
| | | `__| / __| | |/ _` |/ _ \ `__|
| | | |    \__ \ | | (_| |  __/ |
|_| |_|    |___/_|_|\__,_|\___|_|

*/

%utl_rbeginx;
parmcards4;
library(dplyr)
library(haven)
library(slider)
source("c:/oto/fn_tosas9x.R")
data<-read_sas("d:/sd1/have.sas7bdat")
data
n <-2   # 2nd highest value per group
window_size <- 3  # Current + previous 2
data <- data %>%
 group_by(GROUP) %>%
 mutate(
   moving_nth = slider::slide_dbl(
     VALUE,
     .f = ~ sort(., decreasing=TRUE)[n],
     .before = window_size - 1,
     .complete = FALSE
   )
 ) %>%
  ungroup()
data<-data %>%
  select(GROUP,TIME,VALUE,moving_nth)
data[data$TIME<window_size,4] <- NA
data
fn_tosas9x(
      inp    = data
     ,outlib ="d:/sd1/"
     ,outdsn ="want"
     )
;;;;
%utl_rendx;

proc print data=sd1.want;
run;quit;

/**************************************************************************************************************************/
/* R                                 SAS                                                                                  */
/*                                                                         MOVING_                                        */
/*   GROUP  TIME VALUE moving_nth    ROWNAMES    GROUP    TIME    VALUE      NTH                                          */
/*                                                                                                                        */
/* 1 A         1     1         NA        1         A        1        1         .                                          */
/* 2 A         2     4         NA        2         A        2        4         .                                          */
/* 3 A         3     5          4        3         A        3        5         4                                          */
/* 4 A         4     2          4        4         A        4        2         4                                          */
/* 5 A         5     3          3        5         A        5        3         3                                          */
/* 6 B         1    50         NA        6         B        1       50         .                                          */
/* 7 B         2    20         NA        7         B        2       20         .                                          */
/* 8 B         3    30         30        8         B        3       30        30                                          */
/* 9 B         4    10         20        9         B        4       10        20                                          */
/* 0 B         5    40         30       10         B        5       40        30                                          */
/**************************************************************************************************************************/

/*___             _       _           _
|___ \   _ __ ___| | __ _| |_ ___  __| |  _ __ ___ _ __   ___  ___
  __) | | `__/ _ \ |/ _` | __/ _ \/ _` | | `__/ _ \ `_ \ / _ \/ __|
 / __/  | | |  __/ | (_| | ||  __/ (_| | | | |  __/ |_) | (_) \__ \
|_____| |_|  \___|_|\__,_|\__\___|\__,_| |_|  \___| .__/ \___/|___/
                                                  |_|
*/


https://github.com/rogerjdeangelis/utl-Rolling-four-month-median-by-group
https://github.com/rogerjdeangelis/utl-betas-for-rolling-regressions
https://github.com/rogerjdeangelis/utl-calculating-a-weighted-or-moving-sum-for-a-window-of-size-three
https://github.com/rogerjdeangelis/utl-calculating-three-year-rolling-moving-weekly-and-annual-daily-standard-deviation
https://github.com/rogerjdeangelis/utl-compute-the-partial-and-total-rolling-sums-for-window-of-size-of-three
https://github.com/rogerjdeangelis/utl-creating-rolling-sets-of-monthly-tables
https://github.com/rogerjdeangelis/utl-forecast-the-next-four-months-using-a-moving-average-time-series
https://github.com/rogerjdeangelis/utl-forecast-the-next-seven-days-using-a--moving-average-model-in-R
https://github.com/rogerjdeangelis/utl-how-to-compare-price-observations-in-rolling-time-intervals
https://github.com/rogerjdeangelis/utl-moving-ten-month-average-by-group
https://github.com/rogerjdeangelis/utl-nearest-sales-date-on-or-before-a-commercial-date-using-r-roll-join-and-wps-r-and-python-sql
https://github.com/rogerjdeangelis/utl-parallell-processing-a-rolling-moving-three-month-ninety-day-skewness-for-five-thousand-variable
https://github.com/rogerjdeangelis/utl-proof-of-concept-using-dosubl-to-create-a-fcmp-like-function-for-a-rolling-sum-of-size-three
https://github.com/rogerjdeangelis/utl-python-r-compute-the-slope-e-of-rolling-window-ofe-size-seven-based-for-a-sine-curve
https://github.com/rogerjdeangelis/utl-roll-up-multiple-values-for-the-same-name-and-date-to-form-unique-name-date-key
https://github.com/rogerjdeangelis/utl-rolling-moving-sum-and-count-over-3-day-window-by-id
https://github.com/rogerjdeangelis/utl-rolling-sum_of-six-months-by-group
https://github.com/rogerjdeangelis/utl-timeseries-rolling-three-day-averages-by-county
https://github.com/rogerjdeangelis/utl-tumbling-goups-of-ten-temperatures-similar-like-rolling-and-moving-means-wps-r-python
https://github.com/rogerjdeangelis/utl-weight-loss-over-thirty-day-rolling-moving-windows-using-weekly-values
https://github.com/rogerjdeangelis/utl-weighted-moving-sum-for-several-variables
https://github.com/rogerjdeangelis/utl_R_moving_average_six_variables_by_group
https://github.com/rogerjdeangelis/utl_calculate-moving-rolling-average-with-gaps-in-years
https://github.com/rogerjdeangelis/utl_calculating_rolling_3_month_skewness_of_prices_by_stock
https://github.com/rogerjdeangelis/utl_calculating_the_rolling_product_using_wps_sas_and_r
https://github.com/rogerjdeangelis/utl_comparison_sas_v_r_increment_a_rolling_sum_with_the_first_value_for_each_id
https://github.com/rogerjdeangelis/utl_count_distinct_ids_in_rolling_overlapping_date_ranges
https://github.com/rogerjdeangelis/utl_excluding_rolling_regressions_with_one_on_more_missing_values_in_the_window
https://github.com/rogerjdeangelis/utl_moving_average_of_centered_timeseries_or_calculate_a_modified_version_of_moving_averages
https://github.com/rogerjdeangelis/utl_nice_hash_example_of_rolling_count_of_dates_plus-minus_2_days_of_current_date
https://github.com/rogerjdeangelis/utl_rolling_means_by-quarter_semiannual_and_yearly
https://github.com/rogerjdeangelis/utl_standard_deviation_of_90_day_rolling_standard_deviations

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
