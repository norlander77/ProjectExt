codeunit 60101 Events
{
    trigger OnRun()
    begin

    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Print", 'OnAfterDoPrintSalesHeader', '', true, true)]
    // procedure ValidateSentEmails(var SalesHeader: Record "Sales Header"; SendAsEmail: Boolean)
    // var
    //     RelatedCust: Record "Xee Project Lines";
    //     Saleslines: Record "Sales Line";
    // begin

    //     if SendAsEmail then begin
    //         Saleslines.SetRange("Document Type", SalesHeader."Document Type");
    //         Saleslines.SetRange("Document No.", SalesHeader."No.");
    //         Saleslines.SetFilter("Xee Product Group", '<>%1', '');
    //         if Saleslines.FindFirst() then;
    //         RelatedCust.SetRange("Customer No.", SalesHeader."Sell-to Customer No.");
    //         RelatedCust.SetRange("Product Group", Saleslines."xee Product Group");
    //         if RelatedCust.FindFirst() then begin
    //             RelatedCust."Generated SQ" := true;
    //             RelatedCust.Validate(Stage, RelatedCust.Stage::Submitted);
    //             RelatedCust.Modify(true);
    //         end;

    //     end;
    // end;

    [EventSubscriber(ObjectType::page, page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
    local procedure MyProcedure(var RecRef: RecordRef; DocumentAttachment: Record "Document Attachment")
    var
        ProjectHEADER: record "Xee Project Header";
    begin
        if DocumentAttachment."Table ID" = Database::"Xee Project Header" then begin


            RecRef.Open(DATABASE::"Xee Project Header");
            if ProjectHEADER.Get(DocumentAttachment."No.") then
                RecRef.GetTable(ProjectHEADER);
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
    local procedure OnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef);
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of
            DATABASE::"Xee Project Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of
            DATABASE::"Xee Project Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
        end;
    end;

    var
}