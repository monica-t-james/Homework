Attribute VB_Name = "Easy"
Sub StockVolume()

  ' Set a variable for specifying the column of interest
  Dim column As Integer
  column = 1

 ' Determine the Last Row
 Dim LastRow As Long

 Dim i As Double
 
 Dim Ticker As Integer
 Ticker = 2
 
 Dim Total As Double
 Total = 0

 For Each ws In Worksheets
    LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
    Ticker = 2
    ws.Cells(1, 9) = "Ticker"
    ws.Cells(1, 10) = "Total Stock Volume"
    
     ' Loop through rows in the column
     For i = 2 To LastRow
        Total = Total + ws.Cells(i, 7).Value
        
        ' Searches for when the value of the next cell is different than that of the current cell
        If ws.Cells(i + 1, column).Value <> ws.Cells(i, column).Value Then
            ws.Cells(Ticker, 9) = ws.Cells(i, column).Value
            ws.Cells(Ticker, 10) = Total
            Ticker = Ticker + 1
            Total = 0
        End If
        
      Next i
      
 Next
End Sub

