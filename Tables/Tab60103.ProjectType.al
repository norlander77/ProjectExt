table 60103 "Xee Project Type"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"Code"; code[25])
        {
            DataClassification = ToBeClassified;
            
        }
        field(2; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }
    
    keys
    {
        key(PK; "Code")
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