#-----------------------------------------------------#
#--------------Algumas funções importantes------------#
#-----------------------------------------------------#
#----------------- IPEADATA REGIONAL -----------------#
#-----------------------------------------------------#

# Limpar environment #
rm(list=ls()) 

# Algumas packages interessantes 3
install.packages("rjson")  # for downloading comtrade
install.packages("comtradr") # for downloading comtrade \ fora do ar - API DA UN REFORMULADA


# Ver duplicatas #
which(duplicated(object$UFMUN))
which(duplicated(object$UFMUNDV))
which(duplicated(DTB2005$UFMUN))
which(duplicated(DTB2005$UFMUNDV))
object[is.na(object)]

# Remover duplicatas #
object <- object[!is.na(object$UFMUNDV),]
# Outra maneira #
na.omit(object)

# Organizar tabelas #
object = object %>% select(CODVAR, UFMUNDV, MESO, MICRO, DAREFDIA, DAREFMES, DAREFANO, 
                       VALOR, CODPUBL)

# "Proc V" #
object <- left_join(object, DTB2005 %>% select(UFMUN, UFMUNDV))
object <- left_join(object, DTB2005 %>% select(UFMUNDV, MESO))
object <- left_join(object, DTB2005 %>% select(UFMUNDV, MICRO))

# Criar coluna CODVAR - Método alternativo #
object
object %>%
  pivot_longer(
    cols = 4:5,
    names_to = "CODVAR",
    values_to = "VALOR",
    cols_vary = "slowest"
  )
# Outra maneira #
object <- gather(object, 
                    key = CODVAR, 
                    value = VALOR, 
                    factor_key = TRUE,
                    3:4)


# transformar colunas para linhas #
# Create a data frame with the previous database #
data <- data.frame(
GRUF = c(11001, 11002, 11003, 11004, 11005),
DESLIG3123 = c(46.238, 14.796, 95.961, 14.524, 197.914),
ADMIS3123 = c(1.477, -28.44, 2.732, 603, 11.392)
)
# Reshape the data frame #
reshaped_data <- gather(data, key = CODVAR, value = VALOR, -GRUF)
# Rename the column #
reshaped_data <- rename(reshaped_data, UFMUNDV = GRUF)
# Print the reshaped data frame #
print(reshaped_data)



# transpondo
dieeseout<- data.frame(dieese[1], stack(dieese[2:28]))



