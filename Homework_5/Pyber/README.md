
# Pyber Analysis

* I expected to see the highest number of rides and drivers in urban cities and the "Total Rides by City Type" and "Total Drivers by City Type" support my assumption, with 67.5% of the total rides and 86% of the total drivers.
* Most of the fares for urban cities are under \$30, indicating shorter rides. This might indicate urban riders are more prone to use the service since it is more affordable. 
* The number of drivers in urban cities is 7 times higher than suburban cities and urban cities get only 2.5 times more rides and 2 times more fares than suburban cities. This might mean that even though suburban drivers might not get as many rides as urban drivers, they might make just as much money.


```python
# Dependencies
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns
```


```python
# Read in data
city_df = pd.read_csv("raw_data/city_data.csv")
city_df.columns
```


```python
ride_df = pd.read_csv("raw_data/ride_data.csv")
ride_df.columns
```


```python
avg_fare_city = ride_df.groupby("city")["fare"].mean()
total_rides_city = ride_df.groupby("city")["ride_id"].count()
total_drivers_city = city_df.groupby("city")["driver_count"].sum()
city_type = city_df.groupby("city")["type"].max()
all_df = pd.merge(city_df, ride_df, on="city")
```

# Bubble Plot of Ride Sharing Data


```python
bubble_plot_df = pd.DataFrame({"avg_fare": avg_fare_city, "total_rides": total_rides_city, "total_drivers": total_drivers_city,\
                               "city_type": city_type})
bubble_plot_df.head()
```


```python
sns.set_style("darkgrid")
sns.lmplot(x="total_rides", y="avg_fare", data=bubble_plot_df, fit_reg=False, hue="city_type", \
           scatter_kws={"s": bubble_plot_df["total_drivers"] * 5, "edgecolor":"black", "alpha": .65}, legend_out=False, \
           palette= ["lightcoral", "lightskyblue", "gold"])
plt.title("Pyber Ride Sharing Data (2016)")
plt.legend(title="City Types")
plt.ylabel("Average Fare ($)")
plt.xlabel("Total Number of Rides (Per City)")
plt.figtext(1,.75, "Note: \nCircle size correlates with driver count per city.", wrap=True, fontsize=12)
plt.savefig("bubble_plot.png", bbox_inches="tight")
plt.show()
```

# Total Fares by City Type


```python
total_fares = all_df.groupby("type")["fare"].sum()
city_type = ["Rural", "Suburban", "Urban"]
explode = (0, 0, 0.1)
colors=["gold", "lightskyblue", "lightcoral"]
total_fares
```


```python
plt.pie(total_fares, labels=city_type, explode=explode, colors=colors, autopct="%1.1f%%", shadow=True, startangle=110)
plt.title("% of Total Fares by City Type")
plt.savefig("Pie_Fares.png")
plt.show()
```

# Total Rides by City Type


```python
total_rides = all_df.groupby("type")["ride_id"].count()
total_rides
```


```python
plt.pie(total_rides, labels=city_type, explode=explode, colors=colors, autopct="%1.1f%%", shadow=True, startangle=120)
plt.title("% of Total Rides by City Type")
plt.savefig("Pie_Rides.png")
plt.show()
```

# Total Drivers by City Type


```python
total_drivers = all_df.groupby("type")["driver_count"].sum()
total_drivers
```


```python
plt.pie(total_drivers, labels=city_type, explode=explode, colors=colors, autopct="%1.1f%%", shadow=True, startangle=170)
plt.title("% of Total Drivers by City Type")
plt.savefig("Pie_Drivers.png")
plt.show()
```
