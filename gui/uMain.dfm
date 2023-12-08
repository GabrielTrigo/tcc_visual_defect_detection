object Form5: TForm5
  Left = 0
  Top = 0
  Caption = 'Visual Defect Detection'
  ClientHeight = 634
  ClientWidth = 1012
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'Calibri'
  Font.Style = []
  FormStyle = fsStayOnTop
  OnCreate = FormCreate
  TextHeight = 21
  object ImgInput: TImage
    Left = 754
    Top = 89
    Width = 250
    Height = 250
    Stretch = True
  end
  object ImgOutput: TImage
    Left = 754
    Top = 376
    Width = 250
    Height = 250
    Stretch = True
  end
  object Label1: TLabel
    Left = 754
    Top = 62
    Width = 51
    Height = 24
    Caption = 'Input:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 754
    Top = 349
    Width = 67
    Height = 24
    Caption = 'Output:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Button1: TButton
    Left = 3
    Top = 13
    Width = 254
    Height = 33
    Caption = '1.0 - Select Images for inspecion'
    TabOrder = 0
    OnClick = Button1Click
  end
  object DBGrid1: TDBGrid
    Left = 3
    Top = 62
    Width = 735
    Height = 564
    Align = alCustom
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
    Left = 263
    Top = 13
    Width = 138
    Height = 34
    Caption = '1.1 - Start'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 407
    Top = 13
    Width = 118
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
      0E0500009619E0BD0100000018000000060008000000030000003B010966696C
      655F6E616D65020049001000010005574944544802000200FF00067374617475
      73020049001000010005574944544802000200FF000966696C655F7061746802
      0049001000010005574944544802000200FF000A636F6E666964656E63650100
      4900100001000557494454480200020064000A636C6173735F6E616D65010049
      0010000100055749445448020002006400046775696401004900100001000557
      4944544802000200640001000A4348414E47455F4C4F47040082001800000001
      0000000000000004000000020000000000000004000000030000000000000004
      0000000400000000000000040000000500000001000000080000000600000002
      0000000800000007000000030000000800000008000000040000000800000005
      400507006263322E706E670900707357616974696E674A00453A5C646F63735C
      466163756C646164655C7463635C61695F707974686F6E5F796F6C6F76385C64
      61746162617365735C646174615C747261696E5C696D616765735C6263322E70
      6E6705400507006263332E706E670900707357616974696E674A00453A5C646F
      63735C466163756C646164655C7463635C61695F707974686F6E5F796F6C6F76
      385C6461746162617365735C646174615C747261696E5C696D616765735C6263
      332E706E67054005060063312E706E670900707357616974696E674900453A5C
      646F63735C466163756C646164655C7463635C61695F707974686F6E5F796F6C
      6F76385C6461746162617365735C646174615C747261696E5C696D616765735C
      63312E706E67054005060063322E706E670900707357616974696E674900453A
      5C646F63735C466163756C646164655C7463635C61695F707974686F6E5F796F
      6C6F76385C6461746162617365735C646174615C747261696E5C696D61676573
      5C63322E706E670C000007006263322E706E670A007073436F6D706C6574654A
      00453A5C646F63735C466163756C646164655C7463635C61695F707974686F6E
      5F796F6C6F76385C6461746162617365735C646174615C747261696E5C696D61
      6765735C6263322E706E6704302E34360662726F6B656E244245364442383741
      2D353143432D343430342D393530412D4230383738413841383832340C000007
      006263332E706E670A007073436F6D706C6574654A00453A5C646F63735C4661
      63756C646164655C7463635C61695F707974686F6E5F796F6C6F76385C646174
      6162617365735C646174615C747261696E5C696D616765735C6263332E706E67
      04302E33310662726F6B656E2434363145334641382D364342392D343339312D
      414435302D3332424645333632394243390C0000060063312E706E670A007073
      436F6D706C6574654900453A5C646F63735C466163756C646164655C7463635C
      61695F707974686F6E5F796F6C6F76385C6461746162617365735C646174615C
      747261696E5C696D616765735C63312E706E6704302E373404676F6F64244142
      4530364244362D313331372D343036432D393044352D33433636343134463646
      42440C0000060063322E706E670A007073436F6D706C6574654900453A5C646F
      63735C466163756C646164655C7463635C61695F707974686F6E5F796F6C6F76
      385C6461746162617365735C646174615C747261696E5C696D616765735C6332
      2E706E6703302E3704676F6F642445353230414533422D414532322D34304543
      2D424230362D383830454344344434333143}
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
  object IdHTTP1: TIdHTTP
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 162
    Top = 327
  end
end
