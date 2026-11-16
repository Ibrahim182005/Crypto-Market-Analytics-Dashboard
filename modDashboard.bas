Attribute VB_Name = "modDashboard"
Option Explicit

Public NextRun As Date
Const START_HOUR As Long = 9    ' 9 AM
Const END_HOUR As Long = 17   ' 5 PM

Public Sub RefreshDashboard()
    Dim ws As Worksheet
    Dim h As Long

    Set ws = ThisWorkbook.Worksheets("TASK 1")
    h = Hour(Now)

    If h >= START_HOUR And h < END_HOUR Then
    ThisWorkbook.RefreshAll
    ws.Columns("D").ColumnWidth = 20
    ws.ChartObjects("chtTop10").Visible = True
    ws.Range("G2").Value = ""
    Else
        ws.ChartObjects("chtTop10").Visible = False
        ws.Range("G2").Value = "Please open in working hours (9 am to 5 pm)."
    End If

    ' re-check every 5 minutes
    NextRun = Now + TimeValue("00:05:00")
    Application.OnTime NextRun, "RefreshDashboard"
End Sub

Public Sub StopRefresh()
    On Error Resume Next
    Application.OnTime NextRun, "RefreshDashboard", , False
End Sub
