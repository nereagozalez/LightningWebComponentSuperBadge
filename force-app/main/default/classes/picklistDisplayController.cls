public with sharing class picklistDisplayController {

    private List<String> listSObjects;
    picklistDisplayController(){
        this.listSObjects = Schema.getGlobalDescribe().keySet();
    }


    @AuraEnabled(cacheable=true)
    public static List<String> displayObject(){
        return this.listSObjects
    }

    @AuraEnabled(cacheable=true)
    public static List<String> displayObjectPickList(){
        List<String> picklist = new List<String>();
        Map<String,Schema.SObjectField> mapFields = Schema.getGlobalDescribe().get( 'Account' ).getDescribe().fields.getMap();
        for( String keyField : mapFields.keySet() ){
            Schema.SObjectField fieldInfo = mapFields.get( keyField );
            if( 'PICKLIST' == String.valueOf( fieldInfo.getDescribe().getType() ) ){
                picklist.add( fieldInfo.getDescribe().getPicklistValues() );
            }
        }
        return picklist;
    }

    @AuraEnabled(cacheable=true)
    public static List<String> displayPickListValues(){
        return Schema.getGlobalDescribe().get( 'Account' ).getDescribe().fields.getMap().get( 'Type' ).getDescribe().getPicklistValues();
    }
}
