#-----------------------------------------------------#
#---------------- Modelo Gravitacional ---------------#
#-----------------------------------------------------#
#----------------------- NIMAS -----------------------#
#-----------------------------------------------------#

# Limpar environment #
rm(list=ls()) 

# Instalar pacotes #
install.packages("gravity")

# Carregar pacotes #
library(gravity)
library(readxl)
library(dplyr)

# Como citar o gravity model #
citation("gravity")

# Definir diretório #
#setwd("  ")

# Definindo base de dados / No-zeros dataset #
data("gravity_no_zeros")
cc <- c("BRA", "CHN", "USA", "JPN", "ITA", "HTI", "PRT", 
        "KEN", "MEX", "FRA", "GBR", "IND", "CAN", "URY", 
        "VNM", "DNK", "BEL", "PER", "BES", "DEU")
GRAV <- filter(gravity_no_zeros, iso_o %in% cc)

# Rodando os modelos #

# Poisson Pseudo Maximum Likelihood (PPML) #
modelo1 <- ppml(
  dependent_variable = "flow",
  distance = "distw",
  additional_regressors = c("rta", "iso_o", "iso_d", "contig", "comcur"),
  data = GRAV
)
  
# Gama pseudo maximum likelihood (GPML) # 
GRAV_log <- GRAV %>%
  mutate(
    lgdp_o = log(gdp_o),
    lgdp_d = log(gdp_d)
  )

modelo2 <-  gpml(
  dependent_variable = "flow",
  distance = "distw",
  additional_regressors = c("rta", "contig", "comcur"),
  income_origin = "gdp_o",
  income_destination = "gdp_d",
  code_origin = "iso_o",
  code_destination = "iso_d",
  robust = FALSE,
  data = GRAV_log
)
