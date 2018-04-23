Attribute VB_Name = "Moderate"
Sub YearlyChange()

  ' Set a variable for specifying the column of interest
  Dim column As Integer
  column = 1

 ' Determine the Last Row
 Dim LastRow As Long
 
 Dim i As Double
 Dim j As Long
 
 Dim Ticker As Integer
 Ticker = 2
 
 Dim Total As Double
 Total = 0
 
 Dim OpenedAt As Double
 Dim ClosedAt As Double
 Dim YearlyChange As Double
 Dim PercentChange As Double
 
 OpenedAt = 0
 ClosedAt = 0
 YearlyChange = 0
 PercentChange = 0
 

 For Each ws In Worksheets
    LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row     ' Look for the last row in the sheet
    Ticker = 2                                          ' Reset to the top of Ticker column of each sheet
    j = 2                                               ' Reset to the top of the <close> column of each sheet
    ws.Cells(1, 9) = "Ticker"                           ' Labels at the top of each worksheet
    ws.Cells(1, 10) = "Yearly Change"
    ws.Cells(1, 11) = "Percent Change"
    ws.Cells(1, 12) = "Total Stock Volume"
    
     ' Loop through rows in the column
     For i = 2 To LastRow
        Total = Total + ws.Cells(i, 7).Value            ' Add the total stock volume for each ticker
        OpenedAt = ws.Cells(j, 3).Value                 ' Save the <open> value at the beginning of each ticker
        ' Searches for when the value of the next cell is different than that of the current cell
        If ws.Cells(i + 1, column).Value <> ws.Cells(i, column).Value Then
            j = i                                       ' Store the last row of the ticker
            ClosedAt = ws.Cells(j, 6).Value             ' Save the <closed> value at the end of each ticker
            YearlyChange = ClosedAt - OpenedAt          ' Calculate the yearly change
            If OpenedAt <> 0 Then
                PercentChange = YearlyChange / OpenedAt     ' Calculate the % change
            Else
                PercentChange = 0
            End If
            ws.Cells(Ticker, 9).Value = ws.Cells(i, column).Value
            ws.Cells(Ticker, 10).Value = YearlyChange
            If YearlyChange >= 0 Then                   ' Format the cells, green for >+0, red for <0
               ws.Cells(Ticker, 10).Interior.ColorIndex = 4
            Else
               ws.Cells(Ticker, 10).Interior.ColorIndex = 3
            End If
            ws.Cells(Ticker, 11).Value = PercentChange
            ws.Cells(Ticker, 11).NumberFormat = "0.00%"
            ws.Cells(Ticker, 12).Value = Total
            Ticker = Ticker + 1                         ' Move to the next row of the Ticker list
            j = j + 1                                   ' Move to the next row of the <close> column
            Total = 0                                   ' Reset the total stock volume
        End If
        
      Next i
      
 Next
End Sub


