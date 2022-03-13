
# Call libraries
library(readxl)
library(latticeExtra)
library(SPEI)

# Import File
Roxas = read_excel("D:/RoxasCity.xlsx")
View(Roxas)

# Computation of Evapotranspiration
Roxas$PET = thornthwaite(Roxas$TMEAN, 11.600265)

# Compute Climatic Water Balance
Roxas$Bal = Roxas$RAINFALL-Roxas$PET

# Create 2 different time series for SPI and SPEI
spi_obj = ts(Roxas[,'RAINFALL'],freq=12,start=c(2005,1))
spei_obj = ts(Roxas[,'Bal'],freq=12,start = c(2005,1))
ts_info(spi_obj) # view time series object info
ts_info(spei_obj) # view time series object info

# Calculate and plot SPI and SPEI
SPI = spi(spi_obj,12)
SPEI = spei(spei_obj,12)

par(mfrow=c(2,1))
plot(SPI)
plot(SPEI)

# Combine the SPI and SPEI time series into one
combined = ts.union(SPI$fitted, SPEI$fitted)
combined = na.omit(combined) # drop NA values

# Rename column names (naming arguments is not functioning so just rename the column names)
colnames(combined) = c("SPI", "SPEI")
View(combined) # for validation

# Plot SPI and SPEI in one with slider
ts_plot(combined, width = 3, Xgrid = TRUE, Ygrid = TRUE, title = 'Roxas City SPI and SPEI Plot')

# Plot SPI and SPEI in one (with slider)
ts_plot(combined, width = 3, slider = TRUE, Xgrid = TRUE, Ygrid = TRUE, title = 'Roxas City SPI and SPEI Plot')
