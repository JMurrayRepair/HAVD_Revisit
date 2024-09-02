library(ggplot2)
library(scales)

df_N1L <- N1.L
df_N1L$System <- "N1"
df_N1L$VN <- "N"
df_N1L$Type <- "Native"
df_N1L$BusySim <- "Yes"
#print(df_N1L)

df_N1U <- N1.U
df_N1U$System <- "N1"
df_N1U$VN <- "N"
df_N1U$Type <- "Native"
df_N1U$BusySim <- "No"
#print(df_N1U)

df_N2L <- N2.L
df_N2L$System <- "N2"
df_N2L$VN <- "N"
df_N2L$Type <- "Native"
df_N2L$BusySim <- "Yes"
#print(df_N2L)

df_N2U <- N2.U
df_N2U$System <- "N2"
df_N2U$VN <- "N"
df_N2U$Type <- "Native"
df_N2U$BusySim <- "No"
#print(df_N2U)

df_V1VHL <- V1V.HL
df_V1VHL$System <- "V1V"
df_V1VHL$VN <- "V"
df_V1VHL$Type <- "VirtualBox"
df_V1VHL$BusySim <- "Yes"
#print(df_V1VHL)

df_V1VHU <- V1V.HU
df_V1VHU$System <- "V1V"
df_V1VHU$VN <- "V"
df_V1VHU$Type <- "VirtualBox"
df_V1VHU$BusySim <- "No"
#print(df_V1VHU)

df_V2VHL <- V2V.HL
df_V2VHL$System <- "V2V"
df_V2VHL$VN <- "V"
df_V2VHL$Type <- "VirtualBox"
df_V2VHL$BusySim <- "Yes"
#print(df_V2VHL)

df_V2VHU <- V2V.HU
df_V2VHU$System <- "V2V"
df_V2VHU$VN <- "V"
df_V2VHU$Type <- "VirtualBox"
df_V2VHU$BusySim <- "No"
#print(df_V2VHU)

df_V3PHU <- V3P.HU
df_V3PHU$System <- "V3P"
df_V3PHU$VN <- "V"
df_V3PHU$Type <- "Proxmox"
df_V3PHU$BusySim <- "No"
#print(df_V3PHU)

df_V3PHL <- V3P.HL
df_V3PHL$System <- "V3P"
df_V3PHL$VN <- "V"
df_V3PHL$Type <- "Proxmox"
df_V3PHL$BusySim <- "Yes"
#print(df_V3PHL)

df_AWS <- AWS
df_AWS$System <- "AWS"
df_AWS$VN <- "V"
df_AWS$Type <- "AWS"
df_AWS$BusySim <- "N/A"
#print(df_AWS)


df_total <- rbind(df_N1L, df_N1U, df_N2L, df_N2U, df_V1VHU, df_V1VHL, df_V2VHL, df_V2VHU, df_V3PHU, df_V3PHL, df_AWS)
#print(df_total)


#All points
ggplot(df_total, aes(x=`NOP`,y=`CPUID`,colour=`VN`, shape=System)) + scale_shape_manual(values = c(8,0,1,15,17,18)) + labs(colour = "Native/Virtual") + geom_point()

#Zoomed in a bit on the main area
ggplot(df_total, aes(x=`NOP`,y=`CPUID`,colour=`VN`, shape=System)) + scale_shape_manual(values = c(8,0,1,15,17,18)) + scale_x_continuous(limits = c(0,250)) + scale_y_continuous(limits = c(0,170000), labels = label_comma()) + labs(colour = "Native/Virtual") + geom_point()

#Zoomed in on the Low-NOP Line
ggplot(df_total, aes(x=`NOP`,y=`CPUID`,colour=`VN`, shape=System)) + scale_shape_manual(values = c(8,0,1,15,17,18)) + scale_x_continuous(limits = c(15,50)) + scale_y_continuous(limits = c(30000,100000), labels = label_comma()) + labs(colour = "Native/Virtual") + geom_point()
ggplot(df_total, aes(x=`NOP`,y=`CPUID`,colour=`BusySim`, shape=System)) + scale_shape_manual(values = c(8,0,1,15,17,18)) + scale_x_continuous(limits = c(15,50)) + scale_y_continuous(limits = c(30000,100000), labels = label_comma()) + labs(colour = "SimulatedBusy") + geom_point()

#NativeZoomed in on the Native and V3P bunch
ggplot(df_total, aes(x=`NOP`,y=`CPUID`,colour=`VN`, shape=System)) + scale_shape_manual(values = c(8,0,1,15,17,18)) + scale_x_continuous(limits = c(15,50)) + scale_y_continuous(limits = c(0,10000), labels = label_comma()) + labs(colour = "Native/Virtual") + geom_point()
#NativeZoomedBusysim
ggplot(df_total, aes(x=`NOP`,y=`CPUID`,colour=`BusySim`, shape=System)) + scale_shape_manual(values = c(8,0,1,15,17,18)) + scale_x_continuous(limits = c(15,50)) + scale_y_continuous(limits = c(0,10000), labels = label_comma()) + labs(colour = "SimulatedBusy") + geom_point()


#Zoomed in on the Virtual cluster (Mainly V2V)
ggplot(df_total, aes(x=`NOP`,y=`CPUID`,colour=`VN`, shape=System)) + scale_shape_manual(values = c(8,0,1,15,17,18)) + scale_x_continuous(limits = c(100,250)) + scale_y_continuous(limits = c(40000,100000), labels = label_comma()) + labs(colour = "Native/Virtual") + geom_point()
ggplot(df_total, aes(x=`NOP`,y=`CPUID`,colour=`BusySim`, shape=System)) + scale_shape_manual(values = c(8,0,1,15,17,18)) + scale_x_continuous(limits = c(100,250)) + scale_y_continuous(limits = c(40000,100000), labels = label_comma()) + labs(colour = "SimulatedBusy") + geom_point()