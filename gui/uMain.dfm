object Form5: TForm5
  Left = 0
  Top = 0
  Caption = 'Visual Defect Detection'
  ClientHeight = 496
  ClientWidth = 742
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'Calibri'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 21
  object Button1: TButton
    Left = 3
    Top = 8
    Width = 254
    Height = 33
    Caption = '1.0 - Select Images for inspecion'
    TabOrder = 0
    OnClick = Button1Click
  end
  object DBGrid1: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 136
    Width = 736
    Height = 357
    Align = alBottom
    DataSource = DataSource1
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -17
    TitleFont.Name = 'Calibri'
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid1DrawColumnCell
  end
  object Button2: TButton
    Left = 3
    Top = 47
    Width = 254
    Height = 34
    Caption = '1.1 - Start'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 3
    Top = 87
    Width = 254
    Height = 34
    Caption = '1.2 - Report'
    TabOrder = 3
    OnClick = Button3Click
  end
  object OpenDialog1: TOpenDialog
    InitialDir = '\ai_python_yolov8\databases\data\train\images'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 48
    Top = 368
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 48
    Top = 304
  end
  object ClientDataSet1: TClientDataSet
    PersistDataPacket.Data = {
      C80000009619E0BD010000001800000006000000000003000000C8000966696C
      655F6E616D65020049001000010005574944544802000200FF00067374617475
      73020049001000010005574944544802000200FF000966696C655F7061746802
      0049001000010005574944544802000200FF000A636F6E666964656E63650100
      4900100001000557494454480200020064000A636C6173735F6E616D65010049
      0010000100055749445448020002006400046775696401004900100001000557
      494454480200020064000000}
    Active = True
    Aggregates = <>
    FileName = 'E:\docs\Faculdade\tcc\bin\data.xml'
    FieldDefs = <
      item
        Name = 'file_name'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 255
      end
      item
        Name = 'status'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 255
      end
      item
        Name = 'file_path'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 255
      end
      item
        Name = 'confidence'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 100
      end
      item
        Name = 'class_name'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 100
      end
      item
        Name = 'guid'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 48
    Top = 248
    object ClientDataSet1file_name: TStringField
      DisplayLabel = 'File name'
      DisplayWidth = 15
      FieldName = 'file_name'
      Size = 255
    end
    object ClientDataSet1status: TStringField
      DisplayLabel = 'Status'
      DisplayWidth = 10
      FieldName = 'status'
      Size = 255
    end
    object ClientDataSet1file_path: TStringField
      DisplayLabel = 'File path'
      DisplayWidth = 50
      FieldName = 'file_path'
      Visible = False
      Size = 255
    end
    object ClientDataSet1confidence: TStringField
      DisplayLabel = 'Confidence'
      DisplayWidth = 15
      FieldName = 'confidence'
    end
    object ClientDataSet1class_name: TStringField
      DisplayLabel = 'Class Name'
      DisplayWidth = 15
      FieldName = 'class_name'
    end
    object ClientDataSet1guid: TStringField
      DisplayLabel = 'GUID'
      FieldName = 'guid'
      Size = 100
    end
  end
end
