

```python
import pandas as pd
```


```python
# Read in files and create data frames
students_csv = "raw_data/students_complete.csv"
students_df = pd.read_csv(students_csv)

schools_csv = "raw_data/schools_complete.csv"
schools_df = pd.read_csv(schools_csv)
schools_df = schools_df.rename(columns={"name": "school"})
```


```python
# Determine totals for the district
total_schools = schools_df["school"].count()
total_students = schools_df["size"].sum()
total_budget = schools_df["budget"].sum()
```


```python
# Determine average math and reading scores for the district
average_math_score = students_df["math_score"].mean()
average_reading_score = students_df["reading_score"].mean()
```


```python
# Determine the number of students that received a score of 70 or greater in math for the whole district
passed_math_df = students_df["math_score"] >= 70  #gives all rows, true or false whether they are >= 70
passed_math_only = students_df.loc[passed_math_df, "math_score"].count() # gives a count of all the names that scored >= 70
passed_math_percent = passed_math_only / total_students * 100
```


```python
# Determine the number of students that received a score of 70 or greater in reading for the whole district
passed_reading_df = students_df["reading_score"] >= 70  #gives all rows, true or false whether they are >= 70
passed_reading_only = students_df.loc[passed_reading_df, "reading_score"].count() # gives a count of all the names that scored >= 70
passed_reading_percent = passed_reading_only / total_students * 100
```


```python
# Determine the overall passing rate in math and reading for the district
overall_passing_rate = (passed_math_percent + passed_reading_percent) / 2
```

# District Summary


```python
district_summary = pd.DataFrame({"Total Schools": [total_schools], "Total Students": [total_students], \
                                 "Total Budget": [total_budget], "Average Math Score": [average_math_score], \
                                  "Average Reading Score":[average_reading_score], "% Passing Math": [passed_math_percent],
                                  "% Passing Reading": [passed_reading_percent], "Overall Passing Rate": [overall_passing_rate]})

district_summary["Total Students"] = district_summary["Total Students"].map("{:,}".format)
district_summary["Total Budget"] = district_summary["Total Budget"].map("${:,.2f}".format)

district_summary = district_summary[["Total Schools", "Total Students", "Total Budget", "Average Math Score", \
                                     "Average Reading Score", "% Passing Math", "% Passing Reading", "Overall Passing Rate"]]
district_summary
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Total Schools</th>
      <th>Total Students</th>
      <th>Total Budget</th>
      <th>Average Math Score</th>
      <th>Average Reading Score</th>
      <th>% Passing Math</th>
      <th>% Passing Reading</th>
      <th>Overall Passing Rate</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>15</td>
      <td>39,170</td>
      <td>$24,649,428.00</td>
      <td>78.985371</td>
      <td>81.87784</td>
      <td>74.980853</td>
      <td>85.805463</td>
      <td>80.393158</td>
    </tr>
  </tbody>
</table>
</div>



=======================================================================================================


```python
# Format school file to the columns needed in final report
by_schools_df = schools_df.rename(columns={"type": "School Type", "size": "Total Students", "budget": "Total School Budget"})
by_schools_df["Per Student Budget"] = by_schools_df["Total School Budget"] / by_schools_df["Total Students"]
by_schools_df = by_schools_df.groupby("school").max()
```


```python
# Math scores >= 70 by school
by_school_passed_math_only = students_df.loc[passed_math_df, ["school", "math_score"]]
by_school_passed_math_only = by_school_passed_math_only.groupby("school").count()
```


```python
# Reading scores >= 70 by school
by_school_passed_reading_only = students_df.loc[passed_reading_df, ["school", "reading_score"]]
by_school_passed_reading_only = by_school_passed_reading_only.groupby("school").count()
```


```python
# Average math and reading scores by school
average_scores = students_df.groupby("school")[["reading_score", "math_score"]].mean()
average_scores = average_scores.rename(columns={"math_score": "Average Math Score", "reading_score": "Average Reading Score"})
average_scores = average_scores[["Average Math Score", "Average Reading Score"]]
average_scores["% Passing Math"] = by_school_passed_math_only["math_score"] / by_schools_df["Total Students"] * 100
average_scores["% Passing Reading"] = by_school_passed_reading_only["reading_score"] / by_schools_df["Total Students"] * 100
average_scores["% Overall Passing Rate"] = (average_scores["% Passing Math"] + average_scores["% Passing Reading"]) / 2
```

# School Summary


```python
school_summary_df = pd.merge(by_schools_df, average_scores, left_index=True, right_index=True)
display_summary_df = school_summary_df.drop("School ID", axis=1)
display_summary_df["Total School Budget"] = display_summary_df["Total School Budget"].map("${:,.2f}".format)
display_summary_df["Per Student Budget"] = display_summary_df["Per Student Budget"].map("${:,.2f}".format)
del display_summary_df.index.name
display_summary_df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>School Type</th>
      <th>Total Students</th>
      <th>Total School Budget</th>
      <th>Per Student Budget</th>
      <th>Average Math Score</th>
      <th>Average Reading Score</th>
      <th>% Passing Math</th>
      <th>% Passing Reading</th>
      <th>% Overall Passing Rate</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Bailey High School</th>
      <td>District</td>
      <td>4976</td>
      <td>$3,124,928.00</td>
      <td>$628.00</td>
      <td>77.048432</td>
      <td>81.033963</td>
      <td>66.680064</td>
      <td>81.933280</td>
      <td>74.306672</td>
    </tr>
    <tr>
      <th>Cabrera High School</th>
      <td>Charter</td>
      <td>1858</td>
      <td>$1,081,356.00</td>
      <td>$582.00</td>
      <td>83.061895</td>
      <td>83.975780</td>
      <td>94.133477</td>
      <td>97.039828</td>
      <td>95.586652</td>
    </tr>
    <tr>
      <th>Figueroa High School</th>
      <td>District</td>
      <td>2949</td>
      <td>$1,884,411.00</td>
      <td>$639.00</td>
      <td>76.711767</td>
      <td>81.158020</td>
      <td>65.988471</td>
      <td>80.739234</td>
      <td>73.363852</td>
    </tr>
    <tr>
      <th>Ford High School</th>
      <td>District</td>
      <td>2739</td>
      <td>$1,763,916.00</td>
      <td>$644.00</td>
      <td>77.102592</td>
      <td>80.746258</td>
      <td>68.309602</td>
      <td>79.299014</td>
      <td>73.804308</td>
    </tr>
    <tr>
      <th>Griffin High School</th>
      <td>Charter</td>
      <td>1468</td>
      <td>$917,500.00</td>
      <td>$625.00</td>
      <td>83.351499</td>
      <td>83.816757</td>
      <td>93.392371</td>
      <td>97.138965</td>
      <td>95.265668</td>
    </tr>
    <tr>
      <th>Hernandez High School</th>
      <td>District</td>
      <td>4635</td>
      <td>$3,022,020.00</td>
      <td>$652.00</td>
      <td>77.289752</td>
      <td>80.934412</td>
      <td>66.752967</td>
      <td>80.862999</td>
      <td>73.807983</td>
    </tr>
    <tr>
      <th>Holden High School</th>
      <td>Charter</td>
      <td>427</td>
      <td>$248,087.00</td>
      <td>$581.00</td>
      <td>83.803279</td>
      <td>83.814988</td>
      <td>92.505855</td>
      <td>96.252927</td>
      <td>94.379391</td>
    </tr>
    <tr>
      <th>Huang High School</th>
      <td>District</td>
      <td>2917</td>
      <td>$1,910,635.00</td>
      <td>$655.00</td>
      <td>76.629414</td>
      <td>81.182722</td>
      <td>65.683922</td>
      <td>81.316421</td>
      <td>73.500171</td>
    </tr>
    <tr>
      <th>Johnson High School</th>
      <td>District</td>
      <td>4761</td>
      <td>$3,094,650.00</td>
      <td>$650.00</td>
      <td>77.072464</td>
      <td>80.966394</td>
      <td>66.057551</td>
      <td>81.222432</td>
      <td>73.639992</td>
    </tr>
    <tr>
      <th>Pena High School</th>
      <td>Charter</td>
      <td>962</td>
      <td>$585,858.00</td>
      <td>$609.00</td>
      <td>83.839917</td>
      <td>84.044699</td>
      <td>94.594595</td>
      <td>95.945946</td>
      <td>95.270270</td>
    </tr>
    <tr>
      <th>Rodriguez High School</th>
      <td>District</td>
      <td>3999</td>
      <td>$2,547,363.00</td>
      <td>$637.00</td>
      <td>76.842711</td>
      <td>80.744686</td>
      <td>66.366592</td>
      <td>80.220055</td>
      <td>73.293323</td>
    </tr>
    <tr>
      <th>Shelton High School</th>
      <td>Charter</td>
      <td>1761</td>
      <td>$1,056,600.00</td>
      <td>$600.00</td>
      <td>83.359455</td>
      <td>83.725724</td>
      <td>93.867121</td>
      <td>95.854628</td>
      <td>94.860875</td>
    </tr>
    <tr>
      <th>Thomas High School</th>
      <td>Charter</td>
      <td>1635</td>
      <td>$1,043,130.00</td>
      <td>$638.00</td>
      <td>83.418349</td>
      <td>83.848930</td>
      <td>93.272171</td>
      <td>97.308869</td>
      <td>95.290520</td>
    </tr>
    <tr>
      <th>Wilson High School</th>
      <td>Charter</td>
      <td>2283</td>
      <td>$1,319,574.00</td>
      <td>$578.00</td>
      <td>83.274201</td>
      <td>83.989488</td>
      <td>93.867718</td>
      <td>96.539641</td>
      <td>95.203679</td>
    </tr>
    <tr>
      <th>Wright High School</th>
      <td>Charter</td>
      <td>1800</td>
      <td>$1,049,400.00</td>
      <td>$583.00</td>
      <td>83.682222</td>
      <td>83.955000</td>
      <td>93.333333</td>
      <td>96.611111</td>
      <td>94.972222</td>
    </tr>
  </tbody>
</table>
</div>



# Top Performing Schools (By Passing Rate)


```python
top_5_schools = school_summary_df.sort_values(["% Overall Passing Rate"], ascending=False)
top_5_schools = top_5_schools.iloc[0:5, :]
del top_5_schools.index.name
top_5_schools
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>School ID</th>
      <th>School Type</th>
      <th>Total Students</th>
      <th>Total School Budget</th>
      <th>Per Student Budget</th>
      <th>Average Math Score</th>
      <th>Average Reading Score</th>
      <th>% Passing Math</th>
      <th>% Passing Reading</th>
      <th>% Overall Passing Rate</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Cabrera High School</th>
      <td>6</td>
      <td>Charter</td>
      <td>1858</td>
      <td>1081356</td>
      <td>582.0</td>
      <td>83.061895</td>
      <td>83.975780</td>
      <td>94.133477</td>
      <td>97.039828</td>
      <td>95.586652</td>
    </tr>
    <tr>
      <th>Thomas High School</th>
      <td>14</td>
      <td>Charter</td>
      <td>1635</td>
      <td>1043130</td>
      <td>638.0</td>
      <td>83.418349</td>
      <td>83.848930</td>
      <td>93.272171</td>
      <td>97.308869</td>
      <td>95.290520</td>
    </tr>
    <tr>
      <th>Pena High School</th>
      <td>9</td>
      <td>Charter</td>
      <td>962</td>
      <td>585858</td>
      <td>609.0</td>
      <td>83.839917</td>
      <td>84.044699</td>
      <td>94.594595</td>
      <td>95.945946</td>
      <td>95.270270</td>
    </tr>
    <tr>
      <th>Griffin High School</th>
      <td>4</td>
      <td>Charter</td>
      <td>1468</td>
      <td>917500</td>
      <td>625.0</td>
      <td>83.351499</td>
      <td>83.816757</td>
      <td>93.392371</td>
      <td>97.138965</td>
      <td>95.265668</td>
    </tr>
    <tr>
      <th>Wilson High School</th>
      <td>5</td>
      <td>Charter</td>
      <td>2283</td>
      <td>1319574</td>
      <td>578.0</td>
      <td>83.274201</td>
      <td>83.989488</td>
      <td>93.867718</td>
      <td>96.539641</td>
      <td>95.203679</td>
    </tr>
  </tbody>
</table>
</div>



# Bottom Performing Schools (By Passing Rate)


```python
bottom_5_schools = school_summary_df.sort_values(["% Overall Passing Rate"])
bottom_5_schools = bottom_5_schools.iloc[0:5, :]
del bottom_5_schools.index.name
bottom_5_schools
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>School ID</th>
      <th>School Type</th>
      <th>Total Students</th>
      <th>Total School Budget</th>
      <th>Per Student Budget</th>
      <th>Average Math Score</th>
      <th>Average Reading Score</th>
      <th>% Passing Math</th>
      <th>% Passing Reading</th>
      <th>% Overall Passing Rate</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Rodriguez High School</th>
      <td>11</td>
      <td>District</td>
      <td>3999</td>
      <td>2547363</td>
      <td>637.0</td>
      <td>76.842711</td>
      <td>80.744686</td>
      <td>66.366592</td>
      <td>80.220055</td>
      <td>73.293323</td>
    </tr>
    <tr>
      <th>Figueroa High School</th>
      <td>1</td>
      <td>District</td>
      <td>2949</td>
      <td>1884411</td>
      <td>639.0</td>
      <td>76.711767</td>
      <td>81.158020</td>
      <td>65.988471</td>
      <td>80.739234</td>
      <td>73.363852</td>
    </tr>
    <tr>
      <th>Huang High School</th>
      <td>0</td>
      <td>District</td>
      <td>2917</td>
      <td>1910635</td>
      <td>655.0</td>
      <td>76.629414</td>
      <td>81.182722</td>
      <td>65.683922</td>
      <td>81.316421</td>
      <td>73.500171</td>
    </tr>
    <tr>
      <th>Johnson High School</th>
      <td>12</td>
      <td>District</td>
      <td>4761</td>
      <td>3094650</td>
      <td>650.0</td>
      <td>77.072464</td>
      <td>80.966394</td>
      <td>66.057551</td>
      <td>81.222432</td>
      <td>73.639992</td>
    </tr>
    <tr>
      <th>Ford High School</th>
      <td>13</td>
      <td>District</td>
      <td>2739</td>
      <td>1763916</td>
      <td>644.0</td>
      <td>77.102592</td>
      <td>80.746258</td>
      <td>68.309602</td>
      <td>79.299014</td>
      <td>73.804308</td>
    </tr>
  </tbody>
</table>
</div>



# Average Math Scores by Grade


```python
ninth_grade = students_df.loc[(students_df["grade"] == "9th"), :]
ninth_grade_avg_math = ninth_grade.groupby("school")["math_score"].mean()
tenth_grade = students_df.loc[(students_df["grade"] == "10th"), :]
tenth_grade_avg_math = tenth_grade.groupby("school")["math_score"].mean()
eleventh_grade = students_df.loc[(students_df["grade"] == "11th"), :]
eleventh_grade_avg_math = eleventh_grade.groupby("school")["math_score"].mean()
twelveth_grade = students_df.loc[(students_df["grade"] == "12th"), :]
twelveth_grade_avg_math = twelveth_grade.groupby("school")["math_score"].mean()
```


```python
math_scores_by_grade = pd.DataFrame({"9th": ninth_grade_avg_math, "10th": tenth_grade_avg_math, \
                                     "11th": eleventh_grade_avg_math, "12th": twelveth_grade_avg_math})
math_scores_by_grade = math_scores_by_grade[["9th", "10th", "11th", "12th"]]
del math_scores_by_grade.index.name
math_scores_by_grade
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>9th</th>
      <th>10th</th>
      <th>11th</th>
      <th>12th</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Bailey High School</th>
      <td>77.083676</td>
      <td>76.996772</td>
      <td>77.515588</td>
      <td>76.492218</td>
    </tr>
    <tr>
      <th>Cabrera High School</th>
      <td>83.094697</td>
      <td>83.154506</td>
      <td>82.765560</td>
      <td>83.277487</td>
    </tr>
    <tr>
      <th>Figueroa High School</th>
      <td>76.403037</td>
      <td>76.539974</td>
      <td>76.884344</td>
      <td>77.151369</td>
    </tr>
    <tr>
      <th>Ford High School</th>
      <td>77.361345</td>
      <td>77.672316</td>
      <td>76.918058</td>
      <td>76.179963</td>
    </tr>
    <tr>
      <th>Griffin High School</th>
      <td>82.044010</td>
      <td>84.229064</td>
      <td>83.842105</td>
      <td>83.356164</td>
    </tr>
    <tr>
      <th>Hernandez High School</th>
      <td>77.438495</td>
      <td>77.337408</td>
      <td>77.136029</td>
      <td>77.186567</td>
    </tr>
    <tr>
      <th>Holden High School</th>
      <td>83.787402</td>
      <td>83.429825</td>
      <td>85.000000</td>
      <td>82.855422</td>
    </tr>
    <tr>
      <th>Huang High School</th>
      <td>77.027251</td>
      <td>75.908735</td>
      <td>76.446602</td>
      <td>77.225641</td>
    </tr>
    <tr>
      <th>Johnson High School</th>
      <td>77.187857</td>
      <td>76.691117</td>
      <td>77.491653</td>
      <td>76.863248</td>
    </tr>
    <tr>
      <th>Pena High School</th>
      <td>83.625455</td>
      <td>83.372000</td>
      <td>84.328125</td>
      <td>84.121547</td>
    </tr>
    <tr>
      <th>Rodriguez High School</th>
      <td>76.859966</td>
      <td>76.612500</td>
      <td>76.395626</td>
      <td>77.690748</td>
    </tr>
    <tr>
      <th>Shelton High School</th>
      <td>83.420755</td>
      <td>82.917411</td>
      <td>83.383495</td>
      <td>83.778976</td>
    </tr>
    <tr>
      <th>Thomas High School</th>
      <td>83.590022</td>
      <td>83.087886</td>
      <td>83.498795</td>
      <td>83.497041</td>
    </tr>
    <tr>
      <th>Wilson High School</th>
      <td>83.085578</td>
      <td>83.724422</td>
      <td>83.195326</td>
      <td>83.035794</td>
    </tr>
    <tr>
      <th>Wright High School</th>
      <td>83.264706</td>
      <td>84.010288</td>
      <td>83.836782</td>
      <td>83.644986</td>
    </tr>
  </tbody>
</table>
</div>



# Average Reading Scores by Grade


```python
ninth_grade_avg_reading = ninth_grade.groupby("school")["reading_score"].mean()
tenth_grade_avg_reading = tenth_grade.groupby("school")["reading_score"].mean()
eleventh_grade_avg_reading = eleventh_grade.groupby("school")["reading_score"].mean()
twelveth_grade_avg_reading = twelveth_grade.groupby("school")["reading_score"].mean()
```


```python
reading_scores_by_grade = pd.DataFrame({"9th": ninth_grade_avg_reading, "10th": tenth_grade_avg_reading, \
                                        "11th": eleventh_grade_avg_reading, "12th": twelveth_grade_avg_reading})
reading_scores_by_grade = reading_scores_by_grade[["9th", "10th", "11th", "12th"]]
del reading_scores_by_grade.index.name
reading_scores_by_grade
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>9th</th>
      <th>10th</th>
      <th>11th</th>
      <th>12th</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Bailey High School</th>
      <td>81.303155</td>
      <td>80.907183</td>
      <td>80.945643</td>
      <td>80.912451</td>
    </tr>
    <tr>
      <th>Cabrera High School</th>
      <td>83.676136</td>
      <td>84.253219</td>
      <td>83.788382</td>
      <td>84.287958</td>
    </tr>
    <tr>
      <th>Figueroa High School</th>
      <td>81.198598</td>
      <td>81.408912</td>
      <td>80.640339</td>
      <td>81.384863</td>
    </tr>
    <tr>
      <th>Ford High School</th>
      <td>80.632653</td>
      <td>81.262712</td>
      <td>80.403642</td>
      <td>80.662338</td>
    </tr>
    <tr>
      <th>Griffin High School</th>
      <td>83.369193</td>
      <td>83.706897</td>
      <td>84.288089</td>
      <td>84.013699</td>
    </tr>
    <tr>
      <th>Hernandez High School</th>
      <td>80.866860</td>
      <td>80.660147</td>
      <td>81.396140</td>
      <td>80.857143</td>
    </tr>
    <tr>
      <th>Holden High School</th>
      <td>83.677165</td>
      <td>83.324561</td>
      <td>83.815534</td>
      <td>84.698795</td>
    </tr>
    <tr>
      <th>Huang High School</th>
      <td>81.290284</td>
      <td>81.512386</td>
      <td>81.417476</td>
      <td>80.305983</td>
    </tr>
    <tr>
      <th>Johnson High School</th>
      <td>81.260714</td>
      <td>80.773431</td>
      <td>80.616027</td>
      <td>81.227564</td>
    </tr>
    <tr>
      <th>Pena High School</th>
      <td>83.807273</td>
      <td>83.612000</td>
      <td>84.335938</td>
      <td>84.591160</td>
    </tr>
    <tr>
      <th>Rodriguez High School</th>
      <td>80.993127</td>
      <td>80.629808</td>
      <td>80.864811</td>
      <td>80.376426</td>
    </tr>
    <tr>
      <th>Shelton High School</th>
      <td>84.122642</td>
      <td>83.441964</td>
      <td>84.373786</td>
      <td>82.781671</td>
    </tr>
    <tr>
      <th>Thomas High School</th>
      <td>83.728850</td>
      <td>84.254157</td>
      <td>83.585542</td>
      <td>83.831361</td>
    </tr>
    <tr>
      <th>Wilson High School</th>
      <td>83.939778</td>
      <td>84.021452</td>
      <td>83.764608</td>
      <td>84.317673</td>
    </tr>
    <tr>
      <th>Wright High School</th>
      <td>83.833333</td>
      <td>83.812757</td>
      <td>84.156322</td>
      <td>84.073171</td>
    </tr>
  </tbody>
</table>
</div>



# Average Scores by School Spending


```python
# Create bins for school budgets
bins = [0, 585, 615, 645, 675]

# Create labels for the bins
spending = ["<\$585", "\$585 - $614", "\$615 - $644", "\$645 - $675"]
```


```python
# Slice the data and place it into bins
rank = pd.cut(school_summary_df["Per Student Budget"], bins, labels=spending)
```


```python
# Add column to main dataframe
school_summary_df["Spending Ranges (Per Student)"] = rank
```


```python
spending_groups = school_summary_df.groupby("Spending Ranges (Per Student)").mean()
spending_groups = spending_groups[["Average Math Score", "Average Reading Score", "% Passing Math", \
                                   "% Passing Reading", "% Overall Passing Rate"]]
spending_groups
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Average Math Score</th>
      <th>Average Reading Score</th>
      <th>% Passing Math</th>
      <th>% Passing Reading</th>
      <th>% Overall Passing Rate</th>
    </tr>
    <tr>
      <th>Spending Ranges (Per Student)</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>&lt;\$585</th>
      <td>83.455399</td>
      <td>83.933814</td>
      <td>93.460096</td>
      <td>96.610877</td>
      <td>95.035486</td>
    </tr>
    <tr>
      <th>\$585 - $614</th>
      <td>83.599686</td>
      <td>83.885211</td>
      <td>94.230858</td>
      <td>95.900287</td>
      <td>95.065572</td>
    </tr>
    <tr>
      <th>\$615 - $644</th>
      <td>79.079225</td>
      <td>81.891436</td>
      <td>75.668212</td>
      <td>86.106569</td>
      <td>80.887391</td>
    </tr>
    <tr>
      <th>\$645 - $675</th>
      <td>76.997210</td>
      <td>81.027843</td>
      <td>66.164813</td>
      <td>81.133951</td>
      <td>73.649382</td>
    </tr>
  </tbody>
</table>
</div>



# Average Scores by School Size


```python
# Create bins for school size
size_bins = [0, 1000, 2000, 5000]

# Create labels for the bins
size_buckets = ["Small (<1000)", "Medium (1000-2000)", "Large (2000-5000)"]
```


```python
# Slice the data and place it into bins
size = pd.cut(school_summary_df["Total Students"], size_bins, labels=size_buckets)
```


```python
# Add column to main dataframe
school_summary_df["School Size"] = size
```


```python
size_groups = school_summary_df.groupby("School Size").mean()
size_groups = size_groups[["Average Math Score", "Average Reading Score", "% Passing Math", "% Passing Reading",\
                           "% Overall Passing Rate"]]
size_groups
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Average Math Score</th>
      <th>Average Reading Score</th>
      <th>% Passing Math</th>
      <th>% Passing Reading</th>
      <th>% Overall Passing Rate</th>
    </tr>
    <tr>
      <th>School Size</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Small (&lt;1000)</th>
      <td>83.821598</td>
      <td>83.929843</td>
      <td>93.550225</td>
      <td>96.099437</td>
      <td>94.824831</td>
    </tr>
    <tr>
      <th>Medium (1000-2000)</th>
      <td>83.374684</td>
      <td>83.864438</td>
      <td>93.599695</td>
      <td>96.790680</td>
      <td>95.195187</td>
    </tr>
    <tr>
      <th>Large (2000-5000)</th>
      <td>77.746417</td>
      <td>81.344493</td>
      <td>69.963361</td>
      <td>82.766634</td>
      <td>76.364998</td>
    </tr>
  </tbody>
</table>
</div>



# Average Scores by School Type


```python
school_type = school_summary_df.groupby("School Type").mean()
school_type = school_type[["Average Math Score", "Average Reading Score", "% Passing Math", "% Passing Reading",\
                           "% Overall Passing Rate"]]
school_type
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Average Math Score</th>
      <th>Average Reading Score</th>
      <th>% Passing Math</th>
      <th>% Passing Reading</th>
      <th>% Overall Passing Rate</th>
    </tr>
    <tr>
      <th>School Type</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Charter</th>
      <td>83.473852</td>
      <td>83.896421</td>
      <td>93.620830</td>
      <td>96.586489</td>
      <td>95.103660</td>
    </tr>
    <tr>
      <th>District</th>
      <td>76.956733</td>
      <td>80.966636</td>
      <td>66.548453</td>
      <td>80.799062</td>
      <td>73.673757</td>
    </tr>
  </tbody>
</table>
</div>


