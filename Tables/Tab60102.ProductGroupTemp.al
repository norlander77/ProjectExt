table 60102 "Product Group Temp"
{
    DataClassification = ToBeClassified;
    TableType = Temporary;

    fields
    {
        field(1; "Product Group"; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Document No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "Document No.","Product Group")
        {
            Clustered = true;
        }
    }

    var

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}