Attribute VB_Name = "Hard"
Sub Greatest()

  ' Set a variable for specifying the column of interest
  Dim column As Integer
  column = 1

 ' Determine the Last Row
 Dim LastRow As Long
 Dim LastRow2 As Long
  
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
      
    LastRow2 = ws.Cells(Rows.Count, 9).End(xlUp).Row    ' Look for the last row in the Ticker list
    GreatestIncrease = 0                                ' Placeholders for "Greatest" numbers
    GreatestDecrease = 0
    GreatestTotalVolume = 0
    
    For i = 2 To LastRow2
        If ws.Cells(i, 11).Value > GreatestIncrease Then
            GreatestIncrease = ws.Cells(i, 11).Value
            GreatestIncreaseTicker = ws.Cells(i, 9).Value
        End If
        If ws.Cells(i, 11).Value <= GreatestDecrease Then
            GreatestDecrease = ws.Cells(i, 11).Value
            GreatestDecreaseTicker = ws.Cells(i, 9).Value
        End If
        If ws.Cells(i, 12).Value > GreatestTotalVolume Then
            GreatestTotalVolume = ws.Cells(i, 12).Value
            GreatestTotalVolumeTicker = ws.Cells(i, 9).Value
        End If
    Next
            
    ws.Cells(1, 16) = "Ticker"
    ws.Cells(1, 17) = "Value"
    ws.Cells(2, 15) = "Greatest % Increase"
    ws.Cells(3, 15) = "Greatest % Decrease"
    ws.Cells(4, 15) = "Greatest Total Volume"
    ws.Cells(2, 16) = GreatestIncreaseTicker
    ws.Cells(3, 16) = GreatestDecreaseTicker
    ws.Cells(4, 16) = GreatestTotalVolumeTicker
    ws.Cells(2, 17) = GreatestIncrease
    ws.Cells(2, 17).NumberFormat = "0.00%"
    ws.Cells(3, 17) = GreatestDecrease
    ws.Cells(3, 17).NumberFormat = "0.00%"
    ws.Cells(4, 17) = GreatestTotalVolume
    ws.Columns("A:Q").AutoFit
      
 Next
End Sub



